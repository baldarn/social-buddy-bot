class AddDisplayNameToChatUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :chat_users, :display_name, :string
  end
end
