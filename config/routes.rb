Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :profiles, only: %i[show edit update]
end
