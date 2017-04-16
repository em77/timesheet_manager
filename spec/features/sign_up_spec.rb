require "rails_helper"

feature "Sign up", :sorcery do
  scenario "user can sign up with matching passwords and username" do
    signup("usertest", "password", "password", "admin")
    expect(page).to have_content "John Admin was created"
  end

  scenario "user can't sign up with non-matching passwords" do
    signup("usertest", "password", "wrongpassword", "admin")
    expect(page).to have_content "Passwords must match"
  end
end
