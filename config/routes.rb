Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :transports, only: [:index, :show, :new, :create, :edit, :update] do
    post 'disabled', on: :member
    post 'enabled', on: :member
    resources :weight_prices, only:[:new, :create, :edit, :update]
    resources :distance_prices, only:[:new, :create, :edit, :update]
    resources :deadlines, only:[:new, :create, :edit, :update]
  end
  resources :vehicles, only: [:index, :show, :new, :create, :edit, :update] do 
    member do 
      post 'available'
      post 'maintenance'
      post 'operating'
    end
    get 'search', on: :collection
  end
  resources :service_orders, only: [:index, :new, :create, :show] do 
    resources :start_service_orders, only: [:new, :create] 
    get 'search', on: :collection
  end
end
