require "rails_helper"

feature "user management" do
  before(:each) do
    @admin = create(:user, :admin)
    signin(@admin.username, "password")
    sleep 1 # Wait for login and redirect to finish
  end

  scenario "admin can change active_status of user", js: true do
    user = create(:user, :employee)
    visit users_path
    find_link("Archive User").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "#{user.full_name} was archived"
    find_link("Show Archived Users").click
    expect(page).to have_content user.full_name

    find_link("Reactivate User").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "#{user.full_name}'s account was made" +
      " active again"
    visit users_path
    expect(page).to have_content user.full_name
  end

  scenario "admin can delete user", js: true do
    user = create(:user, :employee)
    visit users_path
    find_link("Delete User").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "#{user.full_name} was deleted"
    visit users_path
    expect(page).not_to have_content user.full_name
  end

  scenario "admin can edit user's profile type when user has no children" do
    user = create(:user, :employee)
    visit users_path
    within("##{user.username}-row") do
      find_link("Edit User").click
    end
    select("Admin", from: "user_profileable_type")
    find_button("submit_user").click
    expect(page).to have_content "#{user.full_name} updated successfully"
    within("##{user.username}-row") do
      expect(page).to have_content "Admin"
    end
  end

  scenario "admin cannot edit user's profile type when user has children" do
    user = create(:user, :other_admin)
    company = create(:company, :other_admin)
    visit users_path
    within("##{user.username}-row") do
      find_link("Edit User").click
    end
    expect(page).not_to have_content "User type"
  end
end
