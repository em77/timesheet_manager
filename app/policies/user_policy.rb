class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    is_an_admin?
  end

  def create?
    is_an_admin?
  end

  def destroy?
    is_an_admin?
  end

  def edit?
    is_an_admin?
  end

  def update?
    is_an_admin?
  end

  def change_active_status?
    is_an_admin?
  end
end
