Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :mypage, only: [:index]
  resources :product, only: [:show]
end
