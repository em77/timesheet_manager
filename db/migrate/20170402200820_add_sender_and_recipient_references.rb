class AddSenderAndRecipientReferences < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :recipient_user_id
    remove_column :messages, :sender_user_id
    add_reference :messages, :sender, index: true
    add_reference :messages, :recipient, index: true
  end
end
