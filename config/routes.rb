Rails.application.routes.draw do
  # get 'orders/index'
  devise_for :users
  root to: "items#index"
  # root "orders#index"
  resources :items
  resources :items do # ネストの関係
    resources :orders, only: [:index, :create]
  end
end