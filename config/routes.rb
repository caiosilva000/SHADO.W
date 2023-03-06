Rails.application.routes.draw do
  root to: "root#index"
  resources :articles, except: :index
end
