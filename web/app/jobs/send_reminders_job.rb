# frozen_string_literal: true

class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform(config, reminder_type)
    slack_bot = SlackBot.new(config.slack_api_key, config.slack_relax_channel)
    discord_bot = DiscordBot.new(config.discord_api_key, config.discord_relax_channel)

    case reminder_type
    when :coffee
      slack_bot.propose_coffee
      discord_bot.propose_coffee
    when :lunch
      slack_bot.lunch_toghether
      discord_bot.lunch_toghether
    when :walk
      slack_bot.take_a_walk
      discord_bot.take_a_walk
    when :game
      slack_bot.propose_game
      discord_bot.propose_game
    end
  end
end
