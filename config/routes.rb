Rails.application.routes.draw do
  resources :users, except: [:index]
  resources :packages, only: [:index, :show]

  get  '/login'  => 'sessions#new', as: 'login'
  post '/login'  => 'sessions#create'
  get  '/logout' => 'sessions#destroy', as: 'logout'

  namespace :api do
    resources :packages, only: [:show, :create, :update, :destroy] do
      member do
        get :download
      end
    end
  end

  root 'packages#index'
end
