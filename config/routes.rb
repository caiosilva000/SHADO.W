Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#show"
  get '/users', to: 'pages#index'
  get '/home', to: 'pages#home'
  get '/auth/:provider/callback', to: 'github_auth#github'
  get '/heatmap', to: 'pages#index'
  get '/users/:id', to: 'users#show', as: 'user'
end
