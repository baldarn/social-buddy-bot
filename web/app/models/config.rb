# frozen_string_literal: true

class Config < ApplicationRecord
  belongs_to :user

  after_update :slack_join_social_channel

  def slack_join_social_channel
    return unless slack_api_key.present? && slack_relax_channel.present?

    user.slack_bot.join_social_channel
  end
end
