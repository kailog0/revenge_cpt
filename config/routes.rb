Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "users#index"
  get "/tasks" => "tasks#index"
  
end
