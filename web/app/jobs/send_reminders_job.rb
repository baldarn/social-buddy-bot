# frozen_string_literal: true

class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by_id(user_id)
    return unless user

    event = check_event

    if user.config.slack_api_key
      user.slack_bot.propose_event(event:)
    end
    if user.config.discord_api_key
      user.discord_bot.propose_event(event:)
    end
  ensure
    reschedule(user_id)
  end

  private

  # Calculates and returns the event to shout out at current time,
  # using the super duper secret algorithm
  def check_event
    user_events = user.config.attributes.slice(
      'event_coffee_1_time',
      'event_coffee_2_time',
      'event_lunch_time',
      'event_walk_time',
      'event_game_time'
    )
    user_events.each do |event, time|
      hh = time.to_s[0..1].to_i
      mm = time.to_s[2..3].to_i
      time_obj = Time.now.change({ hour: hh, min: mm })
      if time_obj > 1.minute.ago && time_obj < 2.minutes.from_now
        # event we're looping on is about in a 2 min interval: return it
        return event.split('_')[1].to_sym
        # TODO AVOID CALLING 2 TIMES CONSECUTIVELY
        # TODO MAKE THIS SMARTER (maybe check hoe many people are online)
      end
    end
  end

  def interval
    2.minutes.from_now
  end

  def reschedule(user_id)
    self.class.perform_at(interval, user_id)
  end

end
