require "rails_helper"

feature "employee clock in/out" do
  include ActiveSupport::Testing::TimeHelpers
  
  before(:each) do
    @user = create(:user, :employee)
    @user.profileable.add_company_to_self(create(:company))
    create(:job, :biweekly)
    signin(@user.username, "password")
    sleep 1 # Wait for login and redirect to finish
  end

  scenario "employee can clock in/out", js: true do
    find_button("Clock In").click
    fill_in "timesheet_clock_in", with: "\n" # Press enter
    find_button("submit_timesheet").click
    expect(page).to have_content "Successfully clocked in"

    clock_out_matches = page.all(".clock_out_button")
    clock_out_matches[0].click
    fill_in "timesheet_clock_out", with: "\n" # Press enter
    find_button("submit_timesheet").click
    expect(page).to have_content "Timesheet updated successfully"
    pay_date = Timesheet.last.pay_period.pay_date.strftime("%A, %b %d, %Y")
    expect(page).to have_content pay_date
  end
end

feature "admin timesheet approval" do
  before(:each) do
    @employee = create(:user, :employee)
    @admin = create(:user, :admin)
    @company = create(:company)
    @employee.profileable.add_company_to_self(@company)
    @job = create(:job, :biweekly)
    @pay_period = create(:pay_period)
    @timesheet = create(:timesheet, :regular)
    signin(@admin.username, "password")
    sleep 1 # Wait for login and redirect to finish
  end

  scenario "admin can approve timesheet", js: true do
    visit jobs_path(company_id: @company.id)
    find_link("Timesheets").click
    find_link("pay-period-#{@pay_period.id}").click
    approval_button = find_link("status-#{@timesheet.id}")
    expect(approval_button["class"]).to include("status_unapproved")
    expect(@timesheet.unapproved?).to eq true
    approval_button.click
    sleep 1
    expect(approval_button["class"]).not_to include("status_unapproved")
    expect(approval_button["class"]).to include("status_approved")
    expect(Timesheet.find(@timesheet.id).approved?).to eq true
  end

  scenario "admin can add notes to pay_period", js: true do
    visit jobs_path(company_id: @company.id)
    find_link("Timesheets").click
    find_link("pay-period-#{@pay_period.id}").click
    find_button("edit-notes-toggler").click
    sleep 1.5
    fill_in "pay_period_notes", with: "Hello World!"
    find_button("submit_pay_period_notes").click
    expect(page).to have_content "Notes successfully added to pay period"
    expect(page).to have_content "Hello World!"
  end
end
