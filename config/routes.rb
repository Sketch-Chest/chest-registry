Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  resources :users, only: [:show]
  resources :packages, only: [:index, :show]

  root 'packages#index'
end
