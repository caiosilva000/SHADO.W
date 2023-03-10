Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#index"
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
end
