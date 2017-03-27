module PagesHelper
  def latest_pay_period(job)
    job.pay_periods.where( pay_date: job.pay_periods.maximum(:pay_date) ).first
  end
end
