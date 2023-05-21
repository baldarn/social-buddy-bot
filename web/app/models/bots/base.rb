# frozen_string_literal: true

module Bots
  class Base
    attr_reader :client, :social_channel, :open_ai

    EVENTS = [:coffee, :lunch, :walk, :game]

    def initialize(token:, social_channel:, open_ai_secret: nil)
      raise StandardError.new('No token provided') unless token
      raise StandardError.new('No social channel provided') unless social_channel

      @social_channel = social_channel
      @open_ai = OpenAi.new(open_ai_secret, 'italian') if open_ai_secret
    end

    def get_text(event:)
      open_ai.propose_message(event: event.to_sym) || I18n.t("event_messages.#{event}")
    end
  end
end