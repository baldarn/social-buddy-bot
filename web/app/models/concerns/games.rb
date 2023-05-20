# frozen_string_literal: true

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

    def formatted_for_discord
      game = random_game
      "#{game[:website]}\n\n#{game[:description]}"
    end

    def formatted_for_slack
      game = random_game
      "<#{game[:website]}|#{game[:name]}>\n\n#{game[:description]}"
    end

    def random_game
      @games.sample
    end
  end
end
