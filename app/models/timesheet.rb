class Timesheet < ApplicationRecord
  belongs_to :employee_profile
  belongs_to :job
  enum approved_status: [:unapproved, :approved]
  after_initialize :set_default_approved_status, if: :new_record?

  def set_default_approved_status
    self.approved_status ||= :unapproved
  end
end
