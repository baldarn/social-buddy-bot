# frozen_string_literal: true

module Bots
  class Slack < Base
    attr_reader :client

    def initialize(token:, social_channel:, open_ai_secret: nil)
      super(token:, social_channel:, open_ai_secret:)
      @client = Slack::Web::Client.new(token:)
    end

    def users
      client.users_list[:members].filter { |m| !m['is_bot'] && m['name'] != 'Slackbot' }
    end

    def propose_event(event:)
      text = get_text(event:)
      text = integrate_text(event:, text:)
      client.chat_postMessage(channel: social_channel, text:, as_user: true)
    end

    def integrate_text(event:, text:)
      case event
      when :game
        "#{text}\n#{Games.formatted_for_slack}"
      else
        text
      end
    end
  end
end
