class CompanyPolicy < ApplicationPolicy
  attr_reader :current_user, :company

  def initialize(current_user, model)
    @current_user = current_user
    @company = model
  end

  def new?
    create?
  end

  def create?
    is_an_admin?
  end

  def destroy?
    is_an_admin? && (company.admin_profile_id == current_user.profileable_id)
  end

  def edit?
    destroy?
  end

  def update?
    destroy?
  end

  def show?
    destroy?
  end

  def change_active_status?
    destroy?
  end
end
