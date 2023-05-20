# frozen_string_literal: true

namespace :bot do
  desc 'Generate reminders'
  task generate_reminders: [:environment] do
    User.all.each do |user|
      config = user.config
      if config.slack_api_key.present? && config.slack_relax_channel.present?
        puts "Generating slack reminders for user #{user.email}"
        slack_bot = SlackBot.new(config.slack_api_key, config.slack_relax_channel)
        slack_bot.propose_coffee
      end

      next unless config.discord_api_key.present? && config.discord_relax_channel.present?

      puts "Generating discord reminders for user #{user.email}"
      discord_bot = DiscordBot.new(config.discord_api_key, config.discord_relax_channel)
      discord_bot.propose_coffee
    end
  end
end
