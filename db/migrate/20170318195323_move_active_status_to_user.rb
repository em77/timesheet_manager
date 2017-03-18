class MoveActiveStatusToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :employee_profiles, :active_status
    add_column :users, :active_status, :integer
  end
end
