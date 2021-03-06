Rails.application.routes.draw do

  devise_for :users, controllers:{ 
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'products#index'
  resources :mypage, only: [:index]
  resources :products, only: [:index, :show, :new, :buy, :done, :create, :edit, :update, :destroy] do
    member do
      get 'buy'
      post 'pay'
      get 'done'
      get 'selling_product'
    end
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'search', to: 'products#search'
      post 'remove_image_at_index', defaults: { format: 'json' }
    end
  end
  get "products/:id/edit", to: "products#edit", defaults: { format: 'json' }
  get "/transaction/sell", to: "products#new"
  post "/transaction/sell", to: "products#create", defaults: { format: 'json' }
  resources :sizes, only: [:index]
  resources :confirm, only: [:index]
  resources :users, only: [:edit, :update, :index] do
    collection do
      get 'logout'
      get 'selling_products'
    end
  end
  namespace :transaction do
    resources :buy, only: [:index]
  end
  resources :new_register do
    collection do
      get 'index', 'phone_number','address','credit','complete'
    end
  end
  post  '/new_register/complete',to:'new_register#create'
  post   '/like/:product_id' => 'likes#like',   as: 'like'
  delete '/like/:product_id' => 'likes#unlike', as: 'unlike'
  resources :credit_card, only: [:new, :show, :index] do
    collection do
      post 'pay', to: 'credit_card#pay'
      post 'delete', to: 'credit_card#delete'
    end
  end
end
