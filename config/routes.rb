# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'home#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resource :profile, only: [:show, :update]

  resources :users, only: %i[index] do
    member do
      patch :enable
      patch :disable
      patch :grant_admin
      patch :revoke_admin
    end
  end

  scope '/:username' do
    resources :timelines
  end

  if Rails.env.development?
    get '/dev/login', to: 'development#login'
  end
end
