require "rails_helper"

feature "User index page", :sorcery do

  scenario "user's username is displayed" do
    user = create(:user, :admin)
    signin(user.username, "password")
    visit users_path
    expect(page).to have_content user.username
  end
end
