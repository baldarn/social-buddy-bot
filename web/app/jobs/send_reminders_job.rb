# frozen_string_literal: true

class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform(user, event)
    user.slack_bot.propose_event(event:)
    user.discord_bot.propose_event(event:)
  end
end
