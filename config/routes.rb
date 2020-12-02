Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  resources :posts
  resources :sessions, only: %i[new create]

  get 'log-in', to: 'sessions#new', as: 'login'
  get 'log-out', to: 'sessions#destroy', as: 'logout'
end
