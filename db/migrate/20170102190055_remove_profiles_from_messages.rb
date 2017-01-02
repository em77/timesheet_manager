class RemoveProfilesFromMessages < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :admin_profile_id
    remove_column :messages, :employee_profile_id
  end
end
