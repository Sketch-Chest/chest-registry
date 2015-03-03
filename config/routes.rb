Rails.application.routes.draw do
  resources :users, except: [:index]
  resources :packages, only: [:index, :show]

  # sessions
  get  '/login'  => 'sessions#new', as: 'login'
  post '/login'  => 'sessions#create'
  get  '/logout' => 'sessions#destroy', as: 'logout'

  # oauths
  # post   'oauth/callback'  => 'oauths#callback'
  get    'oauth/callback'  => 'oauths#callback' # for use with Github
  get    'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider
  delete 'oauth/:provider' => 'oauths#destroy', :as => :delete_oauth

  root 'packages#index'
end
