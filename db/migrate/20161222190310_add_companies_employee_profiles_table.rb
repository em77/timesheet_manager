class AddCompaniesEmployeeProfilesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :companies_employee_profiles, id: false do |t|
      t.belongs_to :company, index: true
      t.belongs_to :employee_profile, index: true
    end
  end
end
