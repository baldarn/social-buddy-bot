# frozen_string_literal: true

class AddTimePreferencesToConfigs < ActiveRecord::Migration[7.0]
  def change
    add_column :configs, :event_coffee_1_enabled, :boolean, default: true
    add_column :configs, :event_coffee_2_enabled, :boolean, default: true
    add_column :configs, :event_lunch_enabled, :boolean, default: true
    add_column :configs, :event_walk_enabled, :boolean, default: true
    add_column :configs, :event_game_enabled, :boolean, default: true
    add_column :configs, :event_coffee_1_time, :datetime, default: DateTime.now.beginning_of_day + 11.hours
    add_column :configs, :event_coffee_2_time, :datetime, default: DateTime.now.beginning_of_day + 15.hours
    add_column :configs, :event_lunch_time, :datetime, default: DateTime.now.beginning_of_day + 12.hours + 30.minutes
    add_column :configs, :event_walk_time, :datetime, default: DateTime.now.beginning_of_day + 16.hours
    add_column :configs, :event_game_time, :datetime, default: DateTime.now.beginning_of_day + 17.hours + 30.minutes
  end
end
