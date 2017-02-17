class Timesheet < ApplicationRecord
  belongs_to :pay_period
  enum approved_status: [:unapproved, :approved]
  after_initialize :set_default_approved_status, if: :new_record?

  def set_default_approved_status
    self.approved_status ||= :unapproved
  end

  def add_to_pay_period(job_id)
    pay_period = PayPeriod.where(
      "(? BETWEEN start_date AND end_date) AND job_id = ?",
      self.clock_in, job_id)
    if pay_period[0]
      pay_period[0].timesheets << self
    else
      job = Job.find(job_id)
      pay_period = PayPeriod.pay_freq_to_pay_period_factory(job, self.clock_in)
      pay_period.save
      pay_period.timesheets << self
    end
  end
end
