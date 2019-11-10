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
  resources :new_register do
    collection do
      get 'index', 'phone_number','address','credit','complete'
    end
  end
end
