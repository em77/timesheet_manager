class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.integer :pay_cents
      t.integer :pay_type
      t.references :pay_period
      t.references :employee_profile

      t.timestamps
    end
  end
end
