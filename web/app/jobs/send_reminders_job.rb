# frozen_string_literal: true

class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform(user, event)
    return unless user

    user.slack_bot.propose_event(event:) if user.config.slack_api_key
    user.discord_bot.propose_event(event:) if user.config.discord_api_key
  end
end
