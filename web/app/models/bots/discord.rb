# frozen_string_literal: true

module Bots
  class Discord < Base

    def initialize(token:, social_channel:, open_ai_secret: nil)
      super(token:, social_channel:, open_ai_secret:)
      @client = Discordrb::Bot.new(token:)
    end

    def propose_event(event:)
      text = get_text(event:)
      text = integrate_text(event:, text:)
      client.send_message(social_channel, text)
    end

    def integrate_text(event:, text:)
      case event
      when :game
        "#{text}\n#{Games.formatted_for_discord}"
      else
        text
      end
    end
  end
end