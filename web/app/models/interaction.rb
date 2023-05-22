# frozen_string_literal: true

class Interaction < ApplicationRecord
  belongs_to :chat_user

  scope :last_week, -> { where('created_at > ?', 1.week.ago) }

  scope :last_month, -> { where('created_at > ?', 1.month.ago) }
end
