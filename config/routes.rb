Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "users/:id", to: "pages#show", as: :show
end
