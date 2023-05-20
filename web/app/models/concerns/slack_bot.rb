# frozen_string_literal: true

class SlackBot
  attr_reader :client

  def initialize(token, social_channel, open_ai_secret)
    throw Error.new('No token provided') unless token
    throw Error.new('No social channel provided') unless social_channel
    @client = Slack::Web::Client.new(token:)
    @social_channel = social_channel
    @open_ai = OpenAi.new(open_ai_secret, 'italian') if open_ai_secret
  end

  def users
    @client.users_list[:members].filter { |m| !m['is_bot'] && m['name'] != 'Slackbot' }
  end

  def propose_coffee
    text = @open_ai.propose_coffee_ai || I18n.t('propose_coffee')
    @client.chat_postMessage(channel: @social_channel, text:, as_user: true)
  end

  def take_a_walk
    text = @open_ai.propose_coffee_ai || I18n.t('take_a_walk')
    @client.chat_postMessage(channel: @social_channel, text:, as_user: true)
  end

  def lunch_toghether
    text = @open_ai.propose_coffee_ai || I18n.t('lunch_together')
    @client.chat_postMessage(channel: @social_channel, text:, as_user: true)
  end

  def propose_game
    text = @open_ai.propose_coffee_ai || I18n.t('propose_game')
    @client.chat_postMessage(channel: @social_channel,
                             text: "#{text}\n#{Games.formatted_for_slack}", as_user: true)
  end
end
