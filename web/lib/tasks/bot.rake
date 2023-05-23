# frozen_string_literal: true

namespace :bot do
  desc 'Generate reminders'
  task generate_reminders: [:environment] do
    User.all.each do |user|
      # TODO: timezoned
      config = user.config
      config.event_coffee_1_enabled && SendRemindersJob.set(wait_until: config.event_coffee_1_time)
                                                       .perform_later(user, :coffee)
      config.event_coffee_2_enabled && SendRemindersJob.set(wait_until: config.event_coffee_2_time)
                                                       .perform_later(user, :coffee)
      config.event_lunch_enabled && SendRemindersJob.set(wait_until: config.event_lunch_time)
                                                    .perform_later(user, :lunch)
      config.event_walk_enabled && SendRemindersJob.set(wait_until: config.event_walk_time)
                                                   .perform_later(user, :walk)
      config.event_game_enabled && SendRemindersJob.set(wait_until: config.event_game_time)
                                                   .perform_later(user, :game)
    end
  end

  desc 'Count chat users interactions'
  task count_interactions: [:environment] do
    User.all.each do |user|
      # Slack
      user.slack_bot.users.each do |slack_user|
        chat_user = ChatUser.find_by(user:, platform_id: slack_user.id)
        next if chat_user.present?

        ChatUser.create(
          user:,
          platform_id: slack_user.id,
          name: slack_user.name,
          display_name: slack_user.real_name,
          chat_type: :slack
        )
      end
      messages = user.slack_bot.today_sent_messages
      messages.each do |message|
        users_that_replied = message.reply_users || []
        users_that_reacted = message.reactions&.map(&:users)&.flatten&.uniq || []
        (users_that_reacted | users_that_replied).each do |user_id|
          chat_user = ChatUser.find_by(platform_id: user_id)
          chat_user.add_interaction(platform_id: message.ts) if chat_user.present?
        end
      end

      # Discord TODO:
    end
  end

  desc 'Check up for lowest interacting people'
  task least_interacting: [:environment] do
    User.all.each do |user|
      # Slack
      least_active = user.chat_users.sort_by(&:count_last_week_interactions).reverse
      least_active.first(3).each do |u|
        user.slack_bot.propose_event(user: u.platform_id, event: :least_active)
      end
    end
  end

  desc 'Encourage most interacting people to be engaging'
  task most_interacting: [:environment] do
    User.all.each do |user|
      # Slack
      most_active = user.chat_users.sort_by(&:count_last_week_interactions).reverse
      most_active.first(3).each do |u|
        user.slack_bot.propose_event(user: u.platform_id, event: :most_active)
      end
    end
  end
end
