class PagesController < ApplicationController
  attr_accessor :timesheets, :company_and_job_array, :jobs
  helper_method :timesheets, :company_and_job_array, :jobs

  def home
    if logged_in? && current_user.is_an_admin?
      @timesheets = Timesheet.joins(
        pay_period: { job: :company })
        .where("companies.admin_profile_id = ? AND clock_out IS ?",
        current_user.profileable_id, nil)
        .includes( { pay_period: { job: { employee_profile: :user } } } )
    elsif logged_in?
      @timesheets = Timesheet.joins(
        pay_period: { job: { employee_profile: :user } })
        .where("users.id = ? AND clock_out IS ?",
        current_user.id, nil)
        .includes( pay_period: { job: { employee_profile: :user } } )
      @jobs = current_user.profileable.jobs.includes(:pay_periods)
      @company_and_job_array = company_and_job_array_maker
    end
  end

  def company_and_job_array_maker
    company_and_job_array = []
    jobs = Job.where("employee_profile_id = ?", current_user.profileable_id)
      .includes(:company)
    jobs.each do |job|
      company_and_job_array << ["#{job.title} - #{job.company.title}", job.id]
    end
    company_and_job_array
  end
end
