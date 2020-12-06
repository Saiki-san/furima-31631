Rails.application.routes.draw do
  # get 'orders/index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: "items#index"
  # root "orders#index"
  resources :items
  resources :items do # ネストの関係
    resources :orders, only: [:index, :create]
  end
end