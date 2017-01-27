class TimesheetsController < ApplicationController
  before_action :require_login
  before_action :set_timesheet, only: [:edit, :update, :destroy, :show]
  # before_action :set_pay_period, only: [:new, :index]
  before_action :set_referer, only: [:destroy, :edit, :new]
  after_action :verify_authorized

  attr_accessor :timesheet
  helper_method :timesheet

  def index
    # @timesheets = Timesheet.where("company_id = ?", params.require(:company_id))
    # authorize timesheets
  end

  def new
    @timesheet = Timesheet.new
    authorize timesheet
  end

  def show
  end

  def edit
  end

  def create
    @timesheet = Timesheet.new(timesheet_params)
    authorize timesheet

    if @timesheet.valid?
      @timesheet.save
      job_id = params.require(:timesheet).permit(:job_id)[:job_id]
      @timesheet.add_to_pay_period(job_id)
      redirect_to(session.delete(:return_to) || root_path,
        notice: "Successfully clocked in")
    else
      flash[:error] = @timesheet.errors.full_messages.to_sentence
      redirect_to(session.delete(:return_to) || root_path)
    end
  end

  def update
    if @timesheet.update(timesheet_params)
      job_id = params.require(:timesheet).permit(:job_id)[:job_id]
      @timesheet.add_to_pay_period(job_id)
      flash[:success] = "Timesheet updated successfully"
      redirect_to timesheet_path(timesheet)
    else
      redirect_to timesheet_path(timesheet),
        error: "Timesheet update failed"
    end
  end

  def destroy
    timesheet.destroy
    redirect_to(session.delete(:return_to) || root_path,
      notice: "Timesheet deleted")
  end

  private
    def set_timesheet
      @timesheet = Timesheet.find(params.require(:id))
      authorize timesheet
    end

    def timesheet_params
      params.require(:timesheet).permit(:clock_in, :clock_out, :pay_period_id)
    end
end
