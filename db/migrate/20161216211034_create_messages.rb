class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.belongs_to :admin_profile, index: true
      t.belongs_to :employee_profile, index: true
      t.text :content
      t.integer :read_status
      t.integer :sender_user_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
