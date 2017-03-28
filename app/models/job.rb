class Job < ApplicationRecord
  belongs_to :employee_profile
  belongs_to :company
  has_many :pay_periods
  enum pay_freq: [:biweekly, :monthly]
  enum active_status: [:active, :inactive]
  enum pay_type: [:wage, :shift]
  monetize :pay_cents

  def self.archive_jobs(employee_profile_id)
    Job.where("employee_profile_id = ?", employee_profile_id).each do |job|
      job.inactive!
    end
  end
end
