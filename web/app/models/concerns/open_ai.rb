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
    ret = "write a motivational sentence in #{@language}
      of maximum 40 words to make my collegues"
    case event
    when :coffee
      ret += ' take a coffee.'
    when :lunch
      ret += ' have lunch together.'
    when :walk
      ret += ' take a walk'
    when :game
      ret += ' play an online game'
    end
    ret += 'no traslation and no words count'
    ret
  end
end
