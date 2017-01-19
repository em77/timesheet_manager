class Job < ApplicationRecord
  belongs_to :employee_profile
  belongs_to :company
  has_many :pay_periods
  enum pay_freq: [:biweekly, :monthly]
end
