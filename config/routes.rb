Rails.application.routes.draw do
  resources :users

  resources :packages

  root 'packages#index'
end
