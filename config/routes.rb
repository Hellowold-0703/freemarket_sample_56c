Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'top#index'
  resources :mypage, only: [:index]
  resources :products, only: [:index]
end
