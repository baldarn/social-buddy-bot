# frozen_string_literal: true

module Bots
  class Base
    attr_reader :client, :social_channel, :open_ai

    EVENTS = %i[coffee lunch walk game].freeze

    def initialize(token:, social_channel:, open_ai_secret: nil)
      raise StandardError, 'No token provided' unless token
      raise StandardError, 'No social channel provided' unless social_channel

      @social_channel = social_channel
      @open_ai = OpenAi.new(open_ai_secret, 'italian') if open_ai_secret.present?
    end

    def get_text(event:)
      open_ai&.propose_message(event: event.to_sym) || I18n.t("event_messages.#{event}")
    end
  end
end
