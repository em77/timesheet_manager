module Features
  module JobHelpers
    def new_job(company, employee)
      visit jobs_path(company_id: company.id)
      find_link("New Job").click
      fill_in "Title", with: "Clerk"
      fill_in "employee-name-job-field", with: employee.full_name
      sleep 1 # Wait for autocomplete to appear
      fill_in "employee-name-job-field", with: "\n" # Press enter on selected name
      fill_in "pay-field", with: "10.00"
      find_button("submit_job").click
    end
  end
end
