# frozen_string_literal: true

json.extract! config, :id, :slack_api_key, :discord_api_key, :slack_relax_channel, :discord_relax_channel, :created_at,
              :updated_at
json.url config_url(config, format: :json)
