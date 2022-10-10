Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :transports, only: [:index, :show, :new, :create, :edit, :update] do
    post 'disabled', on: :member
    post 'enabled', on: :member
  end
  resources :vehicles, only: [:index, :show, :new, :create, :edit, :update]

end
