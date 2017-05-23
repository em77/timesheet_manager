class Job < ApplicationRecord
  belongs_to :employee_profile, optional: true
  belongs_to :company, optional: true
  has_many :pay_periods
  enum pay_freq: [:biweekly, :monthly]
  enum active_status: [:active, :inactive]
  enum pay_type: [:wage, :shift]
  monetize :pay_cents
  after_initialize :set_default_active_status, if: :new_record?

  def children?
    pay_periods.any?
  end

  def self.archive_employee_jobs(employee_profile_id)
    Job.where("employee_profile_id = ?", employee_profile_id).each do |job|
      job.inactive!
    end
  end

  def self.archive_company_jobs(company_id)
    Job.where("company_id = ?", company_id).each do |job|
      job.inactive!
    end
  end

  def set_default_active_status
    self.active_status ||= :active
  end
end
