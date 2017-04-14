require "rails_helper"

feature "company management" do
  before(:each) do
    @admin = create(:user, :admin)
    signin(@admin.username, "password")
    sleep 1 # Wait for login and redirect to finish
  end

  scenario "admin can create company" do
    @company = build(:company)
    visit companies_path
    find_link("New Company").click
    fill_in "Title", with: @company.title
    find_button("submit_company").click
    expect(page).to have_content "Company created successfully"
    expect(page).to have_content @company.title
  end

  scenario "admin can change active_status of company", js: true do
    @company = create(:company)
    visit companies_path
    find_link("Archive Company").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "#{@company.title} was archived"
    find_link("Show Archived Companies").click
    expect(page).to have_content @company.title

    find_link("Reactivate Company").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "#{@company.title} was made active again"
    visit companies_path
    expect(page).to have_content @company.title
  end

  scenario "admin can delete company", js: true do
    @company = create(:company)
    visit companies_path
    find_link("Delete Company").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "#{@company.title} was deleted"
    visit companies_path
    expect(page).not_to have_content @company.title
  end
end
