# frozen_string_literal: true

class CreateChatUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_users do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :chat_type
      t.string :platform_id
      t.string :name

      t.timestamps
    end

    add_index :chat_users, %i[chat_type platform_id], unique: true
  end
end
