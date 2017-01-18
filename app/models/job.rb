class Job < ApplicationRecord
  belongs_to :employee_profile
  has_many :pay_periods
  enum pay_freq: [:biweekly, :monthly]
end
