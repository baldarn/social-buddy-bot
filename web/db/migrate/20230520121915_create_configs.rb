# frozen_string_literal: true

class CreateConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :configs do |t|
      t.references :user, index: true, foreign_key: true
      t.string :slack_api_key
      t.string :discord_api_key
      t.string :slack_relax_channel
      t.string :discord_relax_channel

      t.timestamps
    end
  end
end
