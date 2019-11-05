Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :mypage, only: [:index]
  resources :products
  resources :creditcards, only: [:index]
  resources :confirm, only: [:index]
  resources :users, only: [:signup, :index, :destroy, :edit]
  namespace :transaction do
    resources :buy, only: [:index]
    resources :sell, only: [:index]
  end
  post   '/like/:product_id' => 'likes#like',   as: 'like'
  delete '/like/:product_id' => 'likes#unlike', as: 'unlike'
end
