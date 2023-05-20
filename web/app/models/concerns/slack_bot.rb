# frozen_string_literal: true

class SlackBot
  attr_reader :client

  def initialize(token, social_channel)
    throw Error.new('No token provided') unless token
    throw Error.new('No social channel provided') unless social_channel
    @client = Slack::Web::Client.new(token:)
    @social_channel = social_channel
  end

  def users
    @client.users_list[:members].filter { |m| !m['is_bot'] && m['name'] != 'Slackbot' }
  end

  def propose_coffee
    @client.chat_postMessage(channel: @social_channel, text: I18n.t('propose_coffee'), as_user: true)
  end

  def take_a_walk
    @client.chat_postMessage(channel: @social_channel, text: I18n.t('take_a_walk'), as_user: true)
  end

  def lunch_toghether
    @client.chat_postMessage(channel: @social_channel, text: I18n.t('lunch_together'), as_user: true)
  end

  def propose_game
    @client.chat_postMessage(channel: @social_channel,
                             text: "#{I18n.t('propose_game')}\n#{Games.formatted_for_slack}", as_user: true)
  end
end
