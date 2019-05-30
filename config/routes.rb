Rails.application.routes.draw do
  root "posts#index"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  as :user do
    get 'me/edit', to: 'devise/registrations#edit'
  end
  get 'me', to: 'users#me'
  get 'me/friends', to: 'users#friends'

  resources :users, only: [:index, :show]
  resources :friend_requests, only: [:create, :update, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :posts
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
