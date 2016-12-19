class Company < ApplicationRecord
  belongs_to :admin_profile
  has_and_belongs_to_many :employee_profiles
  has_many :pay_periods
  enum pay_freq: [:weekly, :biweekly, :monthly]
end
