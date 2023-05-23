# frozen_string_literal: true

module Bots
  class Slack < Base
    def initialize(token:, social_channel:, open_ai_secret: nil)
      super(token:, social_channel:, open_ai_secret:)
      @client = ::Slack::Web::Client.new(token:)
    end

    def join_social_channel
      client.conversations_join(channel: @social_channel)
    end

    def users
      client.users_list[:members].filter { |m| !m['is_bot'] && m['name'] != 'Slackbot' }
    end

    def today_sent_messages
      client
        .conversations_history(
          channel: social_channel,
          include_all_metadata: true,
          oldest: Date.today.to_time.to_i
        )
        .messages
        .select { |m| m.subtype.nil? }
    end

    def propose_event(event:, channel: nil)
      text = get_text(event:)
      text = integrate_text(event:, text:)
      client.chat_postMessage(channel: channel || social_channel, text:, as_user: true)
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
