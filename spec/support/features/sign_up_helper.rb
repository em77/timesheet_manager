module Features
  module SignUpHelpers
    def signup(username, password, password_confirmation, user_type)
      user = create(:user, user_type.to_sym)
      signin(user.username, "password")
      visit new_user_path
      fill_in "Username", with: username
      fill_in "First name", with: user.first_name
      fill_in "Last name", with: user.last_name
      select(user_type.capitalize, from: "user_profileable_type")
      fill_in "Password", with: password
      fill_in "Password confirmation", with: password_confirmation
      click_on "Submit"
    end
  end
end
