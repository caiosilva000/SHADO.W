Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#index"
  get '/users', to: 'pages#index'
  get '/auth/:provider/callback', to: 'github_auth#github'
  get '/heatmap', to: 'pages#index'
  get '/my_profile', to: 'pages#my_profile', as: 'my_profile'
  get '/users/:id', to: 'pages#show', as: 'user'

  resources :users do
    resources :follows, only: ["new", "create"]
  end

  resources :follows, only: ["destroy"]
end
