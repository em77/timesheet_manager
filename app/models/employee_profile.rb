class EmployeeProfile < ApplicationRecord
  has_one :user, as: :profileable
  has_and_belongs_to_many :companies
  has_many :jobs
  enum active_status: [:active, :inactive]
  after_initialize :set_default_active_status, if: :new_record?

  def set_default_active_status
    self.active_status ||= :active
  end

  def add_company_to_self(company)
    return if self.companies.include?(company)
    self.companies << company
  end
end
