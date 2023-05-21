# frozen_string_literal: true

class OpenAi
  def initialize(access_token, language)
    @client = OpenAI::Client.new(access_token:)
    @language = language
  end

  def propose_message(event:)
    ask_open_ai(prompt(event))
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

  def prompt(event)
    case event
    when :coffee
      "write a motivational sentence in #{@language} of maximum 30 words to make my collegues take a coffee"
    when :lunch
      "write a motivational sentence in #{@language} of maximum 30 words to make my collegues have lunch together"
    when :walk
      "write a motivational sentence in #{@language} of maximum 30 words to make my collegues take a walk"
    when :game
      "write a motivational sentence in #{@language} of maximum 30 words to make my collegues to make a online game"
    end
  end
end
