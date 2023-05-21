# frozen_string_literal: true

class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform(config, event)
    slack_bot = Bots::Slack.new(token: config.slack_api_key, social_channel: config.slack_relax_channel)
    discord_bot = Bots::Discord.new(token: config.discord_api_key, social_channel: config.discord_relax_channel)

    slack_bot.propose_event(event:)
    discord_bot.propose_event(event:)
  end
end
