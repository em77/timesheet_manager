class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username,            :null => false
      t.string :profileable_type
      t.integer :profileable_id
      t.references :profileable, polymorphic: true, index: true
      
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end