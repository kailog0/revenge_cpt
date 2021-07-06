Rails.application.routes.draw do
  root to: "users#index"
  get "/tasks" => "tasks#index"
  post "/tasks" => "tasks#create"
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  

  namespace :admin do
    resources :users
  end

  
end
