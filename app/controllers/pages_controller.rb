class PagesController < ApplicationController
  attr_accessor :timesheets, :company_and_job_array
  helper_method :timesheets, :company_and_job_array

  def home
    currently_clocked_in = Timesheet.where("clock_out IS ?", nil)
    if logged_in? && current_user.is_an_admin?
      @timesheets = currently_clocked_in
    elsif logged_in?
      @timesheets = Timesheet.joins(
        pay_period: { job: { employee_profile: :user } })
        .where("users.id = ? AND clock_out IS ?", current_user.id, nil)
      @company_and_job_array = company_and_job_array_maker
    end
  end

  def company_and_job_array_maker
    company_and_job_array = []
    jobs = Job.where("employee_profile_id = ?", current_user.profileable_id)
    jobs.each do |job|
      company_and_job_array << ["#{job.title} - #{job.company.title}", job.id]
    end
    company_and_job_array
  end
end
