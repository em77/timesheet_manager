class AdminProfile < ApplicationRecord
  has_one :user, as: :profileable
  has_many :companies

  def children?
    companies.any?
  end
end
