class CreateAdminProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_profiles do |t|

      t.timestamps
    end
  end
end
