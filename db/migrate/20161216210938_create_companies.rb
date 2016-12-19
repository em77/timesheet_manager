class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.integer :admin_profile_id
      t.integer :pay_freq

      t.timestamps
    end
  end
end
