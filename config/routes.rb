Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  resources :posts
  post 'posts/upload', to: 'posts#upload', as: 'upload'
  post 'posts/:id/like', to: 'posts#like', as: 'like_post'
  get 'assets/:path', to: 'posts#asset', constraints: { path: %r{[^\/]+} }

  resources :sessions, only: %i[new create]

  get 'log-in', to: 'sessions#new', as: 'login'
  get 'log-out', to: 'sessions#destroy', as: 'logout'
end
