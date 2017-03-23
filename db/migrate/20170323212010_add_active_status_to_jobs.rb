class AddActiveStatusToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :active_status, :integer
  end
end
