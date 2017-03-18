module UsersHelper
  def profile_view_name(profileable_type)
    case profileable_type
    when "AdminProfile"
      return "Administrator"
    when "EmployeeProfile"
      return "Employee"
    end
  end
end
