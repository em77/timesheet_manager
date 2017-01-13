class PayPeriod < ApplicationRecord
  belongs_to :company
  has_many :jobs
end
