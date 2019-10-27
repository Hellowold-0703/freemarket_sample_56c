Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :mypage, only: [:index]
  resources :products, only: [:index]
  resources :creditcards, only: [:index]
  resources :confirm, only: [:index]
  resources :users, only: [:signup]
  resources :transaction do
    collection do
      get 'buy', 'sell'
    end
  end
end
