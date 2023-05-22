# frozen_string_literal: true

class CreateInteractions < ActiveRecord::Migration[7.0]
  def change
    create_table :interactions do |t|
      t.references :chat_user, index: true, foreign_key: true
      t.integer :chat_type
      t.string :platform_id, unique: true

      t.timestamps
    end

    add_index :interactions, %i[chat_type platform_id], unique: true
  end
end
