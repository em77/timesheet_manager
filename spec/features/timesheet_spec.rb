require "rails_helper"

feature "employee clock in/out" do
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
  end
end
