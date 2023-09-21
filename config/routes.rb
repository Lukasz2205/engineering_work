Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :posts do
    post '/like', to: 'posts#like', as: 'like'
    post '/unlike', to: 'posts#unlike', as: 'unlike'

    resources :comments, only: %i[create destroy]
  end
  post '/comments/:comment_id/reply', to: 'comments#reply', as: 'reply'
  get '/comments/:comment_id/show_comment', to: 'comments#show_comment', as: 'show_comment'
  get '/comments/:comment_id/hide_comment', to: 'comments#hide_comment', as: 'hide_comment'

  resources :profiles, only: %i[show edit update]
end
