Rails.application.routes.draw do
  devise_for :users
  root to: "pages#index"
  get '/users', to: 'pages#index'
  get '/home', to: 'pages#home'
end
