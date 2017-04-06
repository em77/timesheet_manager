class Company < ApplicationRecord
  belongs_to :admin_profile
  has_many :jobs
  has_and_belongs_to_many :employee_profiles
  enum active_status: [:active, :inactive]
  after_initialize :set_default_active_status, if: :new_record?

  def children?
    employee_profiles.any? || jobs.any?
  end

  def set_default_active_status
    self.active_status ||= :active
  end
end
