Rails.application.routes.draw do
  get 'dashboard' => 'dashboards#index', as: :dashboard
  get 'home' => 'dashboards#home', as: :home

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout

  # oauth
  get 'auth/twitter/callback', to: 'sessions#twitter', as: :twitter_auth
  get 'auth/failure', to: 'sessions#failure'
  get 'auth/twitter', to: 'settings#twitter', as: :settings_twitter

  resources :users, only: [:new, :create]
  get '/settings' => 'settings#index', as: :settings
  post '/settings' => 'settings#update'

  resources :links, only: [:create, :show, :redirection, :destroy]

  get '/:id' => 'links#redirection', as: :redirect_url

  root 'sessions#direct'
end
