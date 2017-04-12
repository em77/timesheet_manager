class JobPolicy < ApplicationPolicy
  attr_reader :current_user, :job

  def initialize(current_user, model)
    @current_user = current_user
    @job = model
  end

  def new?
    create?
  end

  def create?
    is_an_admin?
  end

  def destroy?
    is_an_admin? &&
      (job.company.admin_profile_id == current_user.profileable_id)
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
