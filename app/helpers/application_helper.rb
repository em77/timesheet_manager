module ApplicationHelper
  def flash_class(flash_type)
    case flash_type
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end

  def current_user_companies
    current_user.profileable.companies.active
  end

  def current_user_jobs
    current_user.profileable.jobs.active.includes(:company)
  end

  def hours_calc(clock_in, clock_out)
    clock_out = Time.zone.now if clock_out.nil?
    ( (clock_out - clock_in) / 3600 ).round(2)
  end

  def current_user_clocked_in?
    clocked_in = Timesheet.joins(
      pay_period: { job: { employee_profile: :user } })
      .where("users.id = ? AND clock_out IS ?",
      current_user.id, nil)
    clocked_in.empty? ? false : true
  end
end
