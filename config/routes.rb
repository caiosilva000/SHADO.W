Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#index"

  resources :users do
    resources :bookings, only: [:new, :create]
    resources :follows, only: [:create]
  end

  resources :bookings, only: [:show] do
    member do
      get 'thank_you'
      post 'process_payment'
    end
    resources :payments, only: [:new, :create]
  end

  resources :follows, only: [:destroy]

end
