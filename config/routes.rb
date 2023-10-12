Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'home#index'

  resources :posts do
    resources :comments, only: %i[create destroy]
  end
  resources :likes, only: %i[create destroy]

  post '/comments/:comment_id/reply', to: 'comments#reply', as: 'reply'
  post '/comments/:comment_id/show_comment', to: 'comments#show_comment', as: 'show_comment'
  post '/comments/:comment_id/hide_comment', to: 'comments#hide_comment', as: 'hide_comment'

  resources :profiles, only: %i[show edit update]
end
