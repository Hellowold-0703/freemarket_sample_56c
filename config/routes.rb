Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :mypage, only: [:index]
  resources :products 
  resources :creditcards, only: [:index]
  resources :confirm, only: [:index]
  resources :users, only: [:edit, :update, :index]
  namespace :transaction do
    resources :buy, only: [:index]
    resources :sell, only: [:index]
  end
  resources :new_register do
    collection do
      get 'index', 'phone_number','address','credit','complete'
    end
  end
  post   '/like/:product_id' => 'likes#like',   as: 'like'
  delete '/like/:product_id' => 'likes#unlike', as: 'unlike'
end
