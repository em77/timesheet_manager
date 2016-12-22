class ChangeRecipientIdColumnNameOnMessages < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :recipient_id, :recipient_user_id
  end
end
