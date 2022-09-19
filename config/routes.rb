Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'

  resources :tweets, only: [:index, :create]
  resources :likes, only: [:create]
end
