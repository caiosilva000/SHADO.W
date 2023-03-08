Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#index"
  get '/users', to: 'pages#index'
  get '/auth/:provider/callback', to: 'github_auth#github'
end
