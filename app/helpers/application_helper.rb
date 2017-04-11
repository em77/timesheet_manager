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

  def unread_message_count
    current_user.received_messages.where(read_status: :unread).count
  end

  def hours_calc(clock_in, clock_out)
    clock_out = Time.zone.now if clock_out.nil?
    ( (clock_out - clock_in) / 3600 ).round(2)
  end
end
