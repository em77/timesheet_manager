class CreateTimesheets < ActiveRecord::Migration[5.0]
  def change
    create_table :timesheets do |t|
      t.datetime :clock_in
      t.datetime :clock_out
      t.integer :approved_status
      t.integer :approving_admin_profile_id
      t.references :pay_period

      t.timestamps
    end
  end
end
