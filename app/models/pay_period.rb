class PayPeriod < ApplicationRecord
  belongs_to :company
  has_many :timesheets
end
