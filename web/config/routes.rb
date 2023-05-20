# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  mount Sidekiq::Web => '/sidekiq'

  authenticate :user do
    get '/config', to: 'configs#show'
    get '/config/edit', to: 'configs#edit'
    patch '/config', to: 'configs#update'
  end
end
