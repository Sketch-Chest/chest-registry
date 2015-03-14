Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, except: [:index]
  resources :packages, only: [:index, :show]

  namespace :api do
    resources :packages, only: [:show, :create, :update, :destroy] do
      member do
        get :download
      end
    end
  end

  root 'packages#index'
end
