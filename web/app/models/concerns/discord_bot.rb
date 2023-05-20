# frozen_string_literal: true

class DiscordBot
  attr_reader :client

  def initialize(token, social_channel)
    throw Error.new('No token provided') unless token
    throw Error.new('No social channel provided') unless social_channel
    @client = Discordrb::Bot.new(token:)
    @social_channel = social_channel
  end

  def propose_coffee
    @client.send_message(@social_channel, I18n.t('propose_coffee'))
  end

  def take_a_walk
    @client.send_message(@social_channel, I18n.t('take_a_walk'))
  end

  def lunch_toghether
    @client.send_message(@social_channel, I18n.t('lunch_together'))
  end

  def propose_game
    @client.send_message(@social_channel, "#{I18n.t('propose_game')}\n#{Games.formatted_for_discord}")
  end
end
