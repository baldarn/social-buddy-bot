# frozen_string_literal: true

Slack.configure do |config|
  config.token = Rails.application.credentials[:slack_api_token]
end

class Games
  @games = [
    {
      name: 'Agar.io',
      website: 'https://agar.io/',
      description: 'Un gioco multiplayer in cui controlli una cellula e devi mangiare altre cellule più piccole per crescere.'
    },
    {
      name: 'Skribbl.io',
      website: 'https://skribbl.io/',
      description: 'Un gioco di disegno online in cui i giocatori devono indovinare cosa viene disegnato da un giocatore selezionato.'
    }
  ]

  class << self
    attr_reader :games

    def formatted_for_slack
      game = random_game
      "<#{game[:website]}|#{game[:name]}>\n\n#{game[:description]}"
    end

    def random_game
      @games.sample
    end
  end
end

class SlackBot
  @client = Slack::Web::Client.new
  @social_channel = '#random'
  class << self
    attr_reader :client

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
                               text: "#{I18n.t('propose_game')} #{Games.formatted_for_slack}", as_user: true)
    end
  end
end
