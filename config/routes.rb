Rails.application.routes.draw do
  root "home#index"
  
  # Devise routes
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Friend routes
  resources :friendships, only: [:create, :update, :destroy]
  get "users", to: "friends#index"
  post "add_friend", to: "friends#add_friend"
  patch "accept_friend/:id", to: "friends#accept", as: "accept_friend"
  delete "reject_friend/:id", to: "friends#reject", as: "reject_friend"
  
  # Posts routes
  resources :posts, only: [:index, :new, :create]
  
  get "up" => "rails/health#show", as: :rails_health_check
end