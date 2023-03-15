Rails.application.routes.draw do
  # Root path
  root to: "pages#index"

  # Devise routes
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Custom devise routes
  devise_scope :user do
    # Custom sign in route
    get 'users', to: 'devise/sessions#new'
  end

  # Github OAuth callback route
  get '/auth/:provider/callback', to: 'github_auth#github'

  # Nested user routes
  resources :users, only: [:show] do
    # Nested booking routes
    resources :bookings, only: [:new, :create]
    # Nested follow routes
    resources :follows, only: [:create]
  end

  # Booking member route for thank you page
  resources :bookings, only: [] do
    member do
      get 'thank_you'
    end
  end

  # Availability routes
  resources :availabilities, only: [:new, :create]

  # Nested chatroom routes
  resources :chatrooms, only: :show do
    # Nested message routes
    resources :messages, only: :create
  end

  # Nested room routes
  resources :rooms do
    # Nested message routes
    resources :messages, module: :rooms
  end

  # Follows destroy route
  resources :follows, only: [:destroy]

  # Custom pages routes
  get '/users', to: 'pages#index'
  get '/my_profile', to: 'pages#my_profile', as: 'my_profile'
  get '/my_settings', to: 'pages#my_settings', as: 'my_settings'
  get '/my_bookings', to: 'pages#my_bookings', as: 'my_bookings'
end
