# frozen_string_literal: true

namespace :bot do
  desc 'Generate reminders'
  task generate_reminders: [:environment] do
    User.all.each do |user|
      SendRemindersJob.set(wait_until: DateTime.now.change({ hour: 10 })).perform_later(user, :coffee)
      SendRemindersJob.set(wait_until: DateTime.now.change({ hour: 15 })).perform_later(user, :coffee)
      SendRemindersJob.set(wait_until: DateTime.now.change({ hour: 14 })).perform_later(user, :lunch)
      SendRemindersJob.set(wait_until: DateTime.now.change({ hour: 13, minutes: 45 })).perform_later(user, :walk)
      SendRemindersJob.set(wait_until: DateTime.now.change({ hour: 17, minutes: 30 })).perform_later(user, :game)
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
end
