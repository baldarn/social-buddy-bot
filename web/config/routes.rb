# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    get '/config', to: 'configs#show'
    get '/config/edit', to: 'configs#edit'
    patch '/config', to: 'configs#update'
  end
end
