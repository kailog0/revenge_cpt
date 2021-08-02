# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#index'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :tasks, only: [:index, :create, :update, :destroy]
  resources :helps, only: [:index]
end
