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
    @jobs = Job.where("company_id = ?", params.require(:company_id))
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
    if @job.update(job_params)
      flash[:success] = "Job updated successfully"
      redirect_to jobs_path(company_id: job.company_id)
    else
      redirect_to jobs_path(company_id: job.company_id),
        error: "Job update failed"
    end
  end

  def destroy
    if job.employee_profile.jobs.where(
      "company_id = ?", job.company_id).count == 1
      job.employee_profile.remove_company_from_self(job.company)
    end
    job.destroy
    redirect_to jobs_path(company_id: job.company_id), notice: "Job deleted"
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
