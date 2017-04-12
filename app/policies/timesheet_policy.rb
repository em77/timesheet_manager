class TimesheetPolicy < ApplicationPolicy
  attr_reader :current_user, :timesheet

  def initialize(current_user, model)
    @current_user = current_user
    @timesheet = model
  end

  def index?
    is_an_admin? || @timesheet.pay_period.job
      .employee_profile_id == current_user.profileable_id
  end

  def new?
    create?
  end

  def create?
    true
  end

  def destroy?
    is_an_admin? &&
      (@timesheet.pay_period.job.company.admin_profile_id ==
        current_user.profileable_id)
  end

  def edit?
    is_an_admin? ||
      (
        @timesheet.clock_in && @timesheet.unapproved? &&
        (@timesheet.pay_period.job.employee_profile.id == current_user
          .profileable_id)
      )
  end

  def update?
    true
  end

  def show?
    true
  end

  def toggle_approved?
    is_an_admin?
  end
end
