# frozen_string_literal: true

class OpenAi
  def initialize(access_token, language)
    @client = OpenAI::Client.new(access_token:)
    @language = language
  end

  def propose_coffee_ai
    ask_open_ai(prompt_coffee)
  end

  def propose_lunch_ai
    ask_open_ai(prompt_coffee)
  end

  def propose_walk_ai
    ask_open_ai(prompt_coffee)
  end

  def propose_game_ai
    ask_open_ai(prompt_coffee)
  end

  private

  def ask_open_ai(prompt)
    response = @client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [{ role: 'user', content: prompt.squish }]
      }
    )

    response.dig('choices', 0, 'message', 'content').gsub('`', '')
  end

  def prompt_coffee
    "write a motivational sentence in #{@language} of maximum 30 words to make my collegues take a coffee"
  end

  def prompt_lunch
    "write a motivational sentence in #{@language} of maximum 30 words to make my collegues have lunch together"
  end

  def prompt_walk
    "write a motivational sentence in #{@language} of maximum 30 words to make my collegues take a walk"
  end

  def prompt_game
    "write a motivational sentence in #{@language} of maximum 30 words to make my collegues to make a online game"
  end
end
