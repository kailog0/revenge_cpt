# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#index'
  get '/tasks' => 'tasks#index'
  post '/tasks' => 'tasks#create'
  put '/tasks/:id' => 'tasks#update'
  get '/login' => 'sessions#new'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  namespace :admin do
    resources :users
  end
end
