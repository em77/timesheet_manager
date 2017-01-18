class PayPeriod < ApplicationRecord
  belongs_to :job
  has_many :timesheets
end
