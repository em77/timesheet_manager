require "rails_helper"

feature "Sign in", :sorcery do
  scenario "user can't sign in without being registered" do
    signin("baduser", "password")
    expect(page).to have_content "Invalid email or password"
  end

  scenario "user can sign in with valid login/password" do
    user = create(:user, :admin)
    signin(user.username, "password")
    expect(page).to have_content "Signed in successfully"
  end

  scenario "user can't sign in with invalid username" do
    user = create(:user, :admin)
    signin("invalid@example.com", user.password)
    expect(page).to have_content "Invalid email or password"
  end

  scenario "user can't sign in with invalid password" do
    user = create(:user, :admin)
    signin(user.username, "wrongpassword")
    expect(page).to have_content "Invalid email or password"
  end
end