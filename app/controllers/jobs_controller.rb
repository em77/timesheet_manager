class JobsController < ApplicationController
  before_action :require_login
  before_action :set_job, only: [:edit, :update, :destroy, :show]
  before_action :set_company, only: [:new, :index]
  before_action :set_referer, only: [:destroy, :edit, :new]
  after_action :verify_authorized

  autocomplete :user, :full_name, full: true

  attr_accessor :job, :jobs, :company
  helper_method :job, :jobs, :company

  def index
    if params[:show_inactive]
      @jobs = Job.where(company_id: params.require(:company_id))
        .where(active_status: :inactive)
        .joins(employee_profile: :user)
        .order("last_name ASC, first_name ASC")
        .includes(:pay_periods, employee_profile: :user)
    else
      @jobs = Job.where(company_id: params.require(:company_id))
        .where(active_status: :active)
        .joins(employee_profile: :user)
        .order("last_name ASC, first_name ASC")
        .includes(:pay_periods, employee_profile: :user)
    end
    authorize jobs
  end

  def new
    @job = Job.new
    authorize job
  end

  def show
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    user_id = params.require(:job).permit(:user_id)[:user_id]
    company_id = params.require(:job).permit(:company_id)[:company_id]
    @job.employee_profile_id = User.find(user_id).profileable_id
    authorize job

    if @job.valid?
      @job.save
      job.employee_profile.add_company_to_self(Company.find(company_id))
      redirect_to(session.delete(:return_to) || jobs_path,
        notice: "Job created successfully")
    else
      flash[:error] = @job.errors.full_messages.to_sentence
      redirect_to(session.delete(:return_to) || jobs_path)
    end
  end

  def update
    user_id = params.require(:job).permit(:user_id)[:user_id]
    company_id = params.require(:job).permit(:company_id)[:company_id]
    employee_profile_id = User.find(user_id).profileable_id
    if @job.valid?
      @job.assign_attributes( job_params.merge(
        company_id: company_id, employee_profile_id: employee_profile_id) )
      update_assoc_on_changed_emp
      @job.save
      flash[:success] = "Job updated successfully"
      redirect_to jobs_path(company_id: job.company_id)
    else
      redirect_to jobs_path(company_id: job.company_id),
        error: "Job update failed"
    end
  end

  def update_assoc_on_changed_emp
    return unless job.employee_profile_id_changed?
    job.employee_profile.add_company_to_self(job.company)
    prev_employee_profile = EmployeeProfile.find(job.employee_profile_id_was)
    if prev_employee_profile.only_job_at_company?(job.company)
      prev_employee_profile.remove_company_from_self(job.company)
    end
  end

  def destroy
    if job.employee_profile.only_job_at_company?(job.company)
      job.employee_profile.remove_company_from_self(job.company)
    end
    job.destroy
    redirect_to jobs_path(company_id: job.company_id), notice: "Job deleted"
  end

  def change_active_status
    job = Job.find( params.require(:job_id) )
    authorize job
    if job.active?
      job.inactive!
      flash[:success] = "#{job.employee_profile.user.full_name}'s job" +
      " as #{job.title} was archived."
    else
      job.active!
      job.employee_profile.user.active!
      flash[:success] = "#{job.employee_profile.user.full_name}'s job" +
      " as #{job.title} was made active again."
    end
    redirect_to jobs_path(company_id: job.company_id)
  end

  def get_autocomplete_items(parameters)
    authorize Job, :is_an_admin?
    items = active_record_get_autocomplete_items(parameters)
    items.where(profileable_type: "EmployeeProfile")
  end

  private
    def set_job
      @job = Job.find(params.require(:id))
      authorize job
    end

    def set_company
      @company = Company.find(params.require(:company_id))
    end

    def job_params
      params.require(:job).permit(:pay, :pay_type, :employee_profile_id,
        :company_id, :title, :pay_freq)
    end
end
