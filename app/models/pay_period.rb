class PayPeriod < ApplicationRecord
  belongs_to :job
  has_many :timesheets
  include OrderQuery
  order_query :order_home,
    [:start_date, :desc]

  def self.pay_freq_to_pay_period_factory(job, clock_in)
    return self.biweekly_pay_period_factory(job.id, clock_in) if job.biweekly?
    return self.monthly_pay_period_factory(job.id, clock_in) if job.monthly?
  end

  def self.biweekly_pay_period_factory(job_id, clock_in)
    if clock_in.day <= 15
      start_date = clock_in.to_date.beginning_of_month
      end_date = start_date + 14.days
    else
      start_date = clock_in.to_date.beginning_of_month + 15.days
      end_date = clock_in.to_date.end_of_month
    end
    self.new(start_date: start_date, end_date: end_date,
      pay_date: self.calculate_pay_date("biweekly", end_date), job_id: job_id)
  end

  def self.monthly_pay_period_factory(job_id, clock_in)
    start_date = clock_in.to_date.beginning_of_month
    end_date = clock_in.to_date.end_of_month
    self.new(start_date: start_date, end_date: end_date,
      pay_date: self.calculate_pay_date("monthly", end_date), job_id: job_id)
  end

  def self.calculate_pay_date(pay_freq, end_date)
    if pay_freq.downcase == "biweekly"
      pay_date = self.calculate_biweekly_pay_date(end_date)
    elsif pay_freq.downcase == "monthly"
      pay_date = self.calculate_monthly_pay_date(end_date)
    end
    self.pay_date_adjuster(pay_date)
  end

  def self.calculate_biweekly_pay_date(end_date)
    if end_date.day <= 15
      pay_date = end_date.next_month.beginning_of_month
    else
      pay_date = end_date.next_month.change({day: 15})
    end
    pay_date
  end

  def self.calculate_monthly_pay_date(end_date)
    self.pay_date_adjuster( end_date.next_month.change({day: 15}) )
  end

  def self.weekend?(date)
    date.saturday? || date.sunday?
  end

  def self.work_day?(date)
    true unless self.weekend?(date) || Holidays.on(date, :us)[0]
  end

  def self.pay_date_adjuster(date)
    final_date = date.dup
    until self.work_day?(final_date)
      final_date -= 1.day
    end
    final_date
  end
end
