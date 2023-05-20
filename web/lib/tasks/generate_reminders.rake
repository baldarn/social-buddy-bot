# frozen_string_literal: true

namespace :bot do
  desc 'Generate reminders'
  task generate_reminders: [:environment] do
    User.all.each do |user|
      SendRemindersJob.set(wait_until: DateTime.now.change({ hour: 10 })).perform_later(user.config, :coffee)
      SendRemindersJob.set(wait_until: DateTime.now.change({ hour: 15 })).perform_later(user.config, :coffee)
      SendRemindersJob.set(wait_until: DateTime.now.change({ hour: 14 })).perform_later(user.config, :lunch)
      SendRemindersJob.set(wait_until: DateTime.now.change({ hour: 13, minutes: 45 })).perform_later(user.config, :walk)
      SendRemindersJob.set(wait_until: DateTime.now.change({ hour: 17, minutes: 30 })).perform_later(user.config, :game)
    end
  end
end
