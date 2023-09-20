Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :posts do
    post '/like', to: 'posts#like', as: 'like'
    post '/unlike', to: 'posts#unlike', as: 'unlike'
    resources :comments, only: %i[create destroy]
  end

  resources :profiles, only: %i[show edit update]
end
