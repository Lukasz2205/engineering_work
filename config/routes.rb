Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
  }

  root 'home#index'
  get 'index_lazy', to: 'home#index_lazy', as: 'index_lazy'

  namespace :panel do
    resources :administration, only: %i[index] do
      collection do
        get 'users'
        get 'posts'
      end
    end
  end

  resources :notifications, only: %i[index] do
    collection do
      get 'read_all'
    end
  end

  resources :profiles do
    get    'posts',       to: 'profiles#posts',       as: 'posts'
    get    'liked_posts', to: 'profiles#liked_posts', as: 'liked_posts'
    get    'comments',    to: 'profiles#comments',    as: 'comments'
    get    'followers',   to: 'profiles#followers',   as: 'followers'
    get    'followed',    to: 'profiles#followed',    as: 'followed'
    put    'block',       to: 'profiles#block'
    put    'unblock',     to: 'profiles#unblock'
    post   'follows',     to: 'profiles#follow'
    delete 'unfollow',    to: 'profiles#unfollow'
  end

  resources :posts do
    resources :comments, only: %i[create destroy]
  end
  resources :likes, only: %i[create destroy]
  resources :rooms do
    resources :messages
  end

  get 'private_chat/:profile_id', to: 'rooms#private_chat', as: 'private_chat'

  post '/comments/:comment_id/reply',        to: 'comments#reply',        as: 'reply'
  post '/comments/:comment_id/show_comment', to: 'comments#show_comment', as: 'show_comment'
  post '/comments/:comment_id/hide_comment', to: 'comments#hide_comment', as: 'hide_comment'
end
