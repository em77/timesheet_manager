module ApplicationHelper
  def flash_class(flash_type)
    case flash_type
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end

  def full_name(user_id)
    user = User.find(user_id)
    "#{user.first_name} #{user.last_name}"
  end
end
