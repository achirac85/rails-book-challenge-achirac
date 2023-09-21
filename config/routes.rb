# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root to:'rooms#index'

  resources :hotels
  resources :rooms do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings


end
