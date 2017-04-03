module ApplicationHelper
  def flash_class(flash_type)
    case flash_type
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end

  def current_admin_user_companies
    Company.where(admin_profile_id: current_user.profileable_id)
  end

  def unread_message_count
    current_user.received_messages.where(read_status: :unread).count
  end
end
