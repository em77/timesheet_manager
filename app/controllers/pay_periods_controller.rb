class PayPeriodsController < ApplicationController
  attr_accessor :pay_period
  helper_method :pay_period

  def update
    @pay_period = PayPeriod.find( params.require(:id) )
    job_id = params.require(:pay_period).permit(:job_id)[:job_id]
    if pay_period.valid?
      @pay_period.update(pay_period_params)
      flash[:success] = "Notes successfully added to pay period"
      redirect_to timesheets_path(pay_period_id: pay_period.id, job_id: job_id)
    else
      flash[:error] = "Saving notes to pay period failed"
      redirect_to timesheets_path(pay_period_id: pay_period.id, job_id: job_id)
    end
  end

  private
    def pay_period_params
      params.require(:pay_period).permit(:notes)
    end
end
