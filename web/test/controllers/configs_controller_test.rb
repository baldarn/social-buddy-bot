# frozen_string_literal: true

require 'test_helper'

class ConfigsControllerTest < ActionDispatch::IntegrationTest
  class Authorized < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
      @config = configs(:one)
      sign_in users(:one)
    end

    test 'should show config' do
      get config_url(@config)
      assert_response :success
    end

    test 'should get edit' do
      get '/config/edit'
      assert_response :success
    end

    test 'should update config' do
      patch '/config/',
            params: { config: { discord_api_key: @config.discord_api_key, discord_relax_channel: @config.discord_relax_channel,
                                slack_api_key: @config.slack_api_key, slack_relax_channel: @config.slack_relax_channel } }
      assert_redirected_to config_url(@config)
    end
  end

  class Unauthorized < ActionDispatch::IntegrationTest
    setup do
      @config = configs(:one)
    end

    test 'should show config' do
      get config_url(@config)
      assert_response :unauthorized
    end

    test 'should get edit' do
      get '/config/edit'
      assert_response :redirect
    end

    test 'should update config' do
      patch '/config/',
            params: { config: { discord_api_key: @config.discord_api_key, discord_relax_channel: @config.discord_relax_channel,
                                slack_api_key: @config.slack_api_key, slack_relax_channel: @config.slack_relax_channel } }
      assert_response :redirect
    end
  end
end
