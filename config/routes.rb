Rails.application.routes.draw do
  root to: "pages#index"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [] do
    resources :bookings, only: [:new, :create]
  end
  resources :availabilities, only: [:new, :create]
  get '/users', to: 'pages#index'
  get '/auth/:provider/callback', to: 'github_auth#github'
  get '/my_profile', to: 'pages#my_profile', as: 'my_profile'
  get '/my_bookings', to: 'pages#my_bookings', as: 'my_bookings'
  get '/users/:id', to: 'pages#show', as: 'user'

  resources :users, only: [] do
    resources :follows, only: [:create]
  end
  
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
  resources :follows, only: ["destroy"]
  mount ActionCable.server => '/cable'

end
