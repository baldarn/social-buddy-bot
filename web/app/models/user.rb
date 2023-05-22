# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :config, dependent: :destroy
  has_many :chat_users, dependent: :destroy

  after_create :after_create_tasks

  def slack_bot
    @slack_bot ||= Bots::Slack.new(
      token: config.slack_api_key,
      social_channel: config.slack_relax_channel,
      open_ai_secret: config.open_ai_secret
    )
  end

  def discord_bot
    @discord_bot ||= Bots::Discord.new(
      token: config.discord_api_key,
      social_channel: config.discord_relax_channel,
      open_ai_secret: config.open_ai_secret
    )
  end

  private

  def after_create_tasks
    generate_config
    schedule_job
  end

  def generate_config
    Config.create(user: self)
  end

  def schedule_job
    SendRemindersJob.perform_at(10.seconds.from_now)
  end
end
