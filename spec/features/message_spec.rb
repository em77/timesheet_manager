require "rails_helper"

feature "Send message" do
  before(:each) do
    Capybara.default_max_wait_time = 10
    @admin = create(:user, :admin)
    @employee = create(:user, :employee)
    @message = create(:message)
    @message2 = create(:message, :second_message)
    @company = create(:company)
    @company.admin_profile_id = @admin.profileable.id
    @employee.profileable.companies << @company
  end

  scenario "admin can send message to employee", js: true do
    signin(@admin.username, "password")
    sleep 1 # Wait for login and redirect to finish
    visit new_message_path
    fill_in "employee-name-field", with: @employee.full_name
    sleep 1 # Wait for autocomplete to appear
    fill_in "employee-name-field", with: "\n" # Press enter on selected name
    fill_in "Subject", with: @message.subject
    fill_in "Message", with: @message.content
    find_button("submit_message").click
    expect(page).to have_content "Message sent successfully"
    find_link(@message.subject).click
    expect(page).to have_content "From: #{@admin.full_name}"
    expect(page).to have_content "To: #{@employee.full_name}"
  end

  scenario "employee can send message to a company they work for" do
    signin(@employee.username, "password")
    visit new_message_path
    select(@company.title, from: "message_recipient_id")
    fill_in "Subject", with: @message2.subject
    fill_in "Message", with: @message2.content
    find_button("submit_message").click
    expect(page).to have_content "Message sent successfully"
    find_link(@message2.subject).click
    expect(page).to have_content "From: #{@employee.full_name}"
    expect(page).to have_content "To: #{@admin.full_name}"
  end
end
