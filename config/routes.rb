Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'home#index'
  get 'index_lazy', to: 'home#index_lazy', as: 'index_lazy'

  namespace :panel do
    resources :administration
  end

  resources :profiles, only: %i[show edit update destroy] do
    get 'posts', to: 'profiles#posts', as: 'posts'
    get 'liked_posts', to: 'profiles#liked_posts', as: 'liked_posts'
    get 'comments', to: 'profiles#comments', as: 'comments'
  end

  resources :posts do
    resources :comments, only: %i[create destroy]
  end
  resources :likes, only: %i[create destroy]
  resources :rooms do
    resources :messages
  end

  get 'private_chat/:profile_id', to: 'rooms#private_chat', as: 'private_chat'

  post 'follow', to: 'profiles#follow'
  delete 'unfollow', to: 'profiles#unfollow'

  post '/comments/:comment_id/reply', to: 'comments#reply', as: 'reply'
  post '/comments/:comment_id/show_comment', to: 'comments#show_comment', as: 'show_comment'
  post '/comments/:comment_id/hide_comment', to: 'comments#hide_comment', as: 'hide_comment'
end
