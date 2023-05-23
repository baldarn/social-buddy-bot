class AddTimePreferencesToConfigs < ActiveRecord::Migration[7.0]
  def change
    add_column :configs, :event_coffee_1_enabled, :boolean, default: true
    add_column :configs, :event_coffee_2_enabled, :boolean, default: true
    add_column :configs, :event_lunch_enabled, :boolean, default: true
    add_column :configs, :event_walk_enabled, :boolean, default: true
    add_column :configs, :event_game_enabled, :boolean, default: true
    add_column :configs, :event_coffee_1_time, :integer, default: 1000
    add_column :configs, :event_coffee_2_time, :integer, default: 1500
    add_column :configs, :event_lunch_time, :integer, default: 1230
    add_column :configs, :event_walk_time, :integer, default: 1600
    add_column :configs, :event_game_time, :integer, default: 1730
  end
end
