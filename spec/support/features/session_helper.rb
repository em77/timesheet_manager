module Features
  module SessionHelpers
    def signin(username, password)
      visit new_user_session_path
      fill_in "Username", with: username
      fill_in "Password", with: password
      click_on "sign_in_submit"
    end
  end
end
