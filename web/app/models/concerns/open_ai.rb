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
      of maximum 40 words to ask my"
    case event
    when :coffee
      ret += ' collegues'
      ret += ' take a coffee'
    when :lunch
      ret += ' collegues'
      ret += ' have lunch together'
    when :walk
      ret += ' collegues'
      ret += ' take a walk'
    when :game
      ret += ' collegues'
      ret += ' play an online game'
    when :most_active
      ret += ' collegue'
      ret += ' to ask others to interact. Also ask to propose to other collegues activities'
    when :least_active
      ret += ' collegue'
      ret += ' if everything is ok. Also ask if you want to partecipate to the next activity'
    end
    ret += '. no traslation and no words count'
    ret
  end
end
