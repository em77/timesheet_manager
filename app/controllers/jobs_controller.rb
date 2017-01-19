class JobsController < ApplicationController
  before_action :require_login
  before_action :set_job, only: [:edit, :update, :destroy, :show]
  before_action :set_referer, only: [:destroy, :edit, :new]
  after_action :verify_authorized

  attr_accessor :job, :jobs
  helper_method :job, :jobs

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
    authorize job

    if @job.valid?
      @job.save
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
      redirect_to jobs_path
    else
      redirect_to jobs_path, error: "Job update failed"
    end
  end

  def destroy
    job.destroy
    redirect_to jobs_path, notice: "Job deleted"
  end

  private
    def set_job
      @job = Job.find(params.require(:id))
      authorize job
    end

    def job_params
      params.require(:job).permit(:pay_cents, :pay_type, :employee_profile_id,
        :company_id, :title, :pay_freq)
    end
end
