Rails.application.routes.draw do
  root 'top#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :mypage, only: [:index]
  resources :products
  resources :creditcards, only: [:index]
  resources :confirm, only: [:index]
  resources :users, only: [:signup, :index, :destroy, :edit]
  namespace :transaction do
    resources :buy, only: [:index]
    resources :sell, only: [:index]
  end
end
