Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :transports, only: [:index, :show]
  
end
