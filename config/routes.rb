Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :mypage, only: [:index]
  resources :products, only: [:index]
  resources :creditcards, only: [:index]
  resources :users, only: [:signup]
end
