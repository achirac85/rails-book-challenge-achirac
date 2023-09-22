# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :hotels
  resources :rooms do
    resources :bookings, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  resources :bookings


end
