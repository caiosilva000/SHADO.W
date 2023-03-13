Rails.application.routes.draw do

  resources :chat_rooms, only: [:index, :show, :create] do
    post 'join', on: :member
    # add a new route here
    get 'new_route', to: 'chat_rooms#new_route_method'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "chat_rooms#show"
  resources :users, only: [] do
    resources :bookings, only: [:new, :create]
  end
  get '/users', to: 'pages#index'
  get '/auth/:provider/callback', to: 'github_auth#github'
  get '/heatmap', to: 'pages#index'
  get '/my_profile', to: 'pages#my_profile', as: 'my_profile'
  get '/my_bookings', to: 'pages#my_bookings', as: 'my_bookings'
  get '/users/:id', to: 'pages#show', as: 'user'

  resources :users do
    resources :follows, only: ["new", "create"]
  end

  resources :follows, only: ["destroy"]
  mount ActionCable.server => '/cable'
end

