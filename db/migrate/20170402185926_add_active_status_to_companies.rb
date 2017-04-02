class AddActiveStatusToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :active_status, :integer
  end
end
