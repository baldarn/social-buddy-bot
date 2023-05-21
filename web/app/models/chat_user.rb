# frozen_string_literal: true

class ChatUser < ApplicationRecord
  belongs_to :user
  has_many :interactions, dependent: :destroy

  enum :chat_type, %i[slack discord]

  def add_interaction(platform_id:)
    interactions << Interaction.create(chat_type:, platform_id:)
  rescue StandardError => e
  end

  def count_last_week_interactions
    interactions.last_week.count
  end

  def count_last_month_interactions
    interactions.last_month.count
  end
end
