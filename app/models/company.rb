class Company < ApplicationRecord
  belongs_to :admin_profile
  has_many :jobs
  has_and_belongs_to_many :employee_profiles
  enum active_status: [:active, :inactive]
end
