# frozen_string_literal: true

class AddOpenAiTokenToConfigs < ActiveRecord::Migration[7.0]
  def change
    add_column :configs, :open_ai_secret, :string
  end
end
