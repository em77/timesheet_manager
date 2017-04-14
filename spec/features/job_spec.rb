require "rails_helper"

feature "job management" do
  before(:each) do
    @admin = create(:user, :admin)
    @employee = create(:user, :employee)
    @company = create(:company)
    signin(@admin.username, "password")
    sleep 1 # Wait for login and redirect to finish
  end

  scenario "admin can create new job", js: true do
    new_job(@company, @employee)
    expect(page).to have_content "Job created successfully"
  end

  scenario "admin can change active_status of job", js: true do
    new_job(@company, @employee)
    sleep 1 # wait for job to finish saving
    job = Job.last
    visit jobs_path(company_id: @company.id)
    find_link("Archive Job").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "#{job.title} was archived"
    find_link("Show Archived Jobs").click
    expect(page).to have_content job.title

    find_link("Reactivate Job").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "#{job.title} was made active again"
    visit jobs_path(company_id: @company.id)
    expect(page).to have_content job.title
  end

  scenario "admin can delete job", js: true do
    new_job(@company, @employee)
    sleep 1 # wait for job to finish saving
    job = Job.last
    find_link("Delete Job").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "Job deleted"
    expect(page).not_to have_content job.title
  end
end
