class Job < ApplicationRecord
  belongs_to :employee_profile
  belongs_to :pay_period
  has_many :timesheets
end
