require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get 'dashboard' => 'dashboards#index', as: :dashboard
  get 'home' => 'dashboards#home', as: :home

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout

  # oauth
  get 'auth/twitter/callback', to: 'sessions#twitter', as: :twitter_auth
  get 'auth/failure', to: 'sessions#failure'

  resources :users, only: [:new, :show, :create]
  get '/settings' => 'settings#index', as: :settings
  post '/settings' => 'settings#update'
  put '/settings/regenerate_key' => 'settings#regenerate_key'

  resources :links, only: [:create, :show, :redirection, :destroy]

  get '/:id' => 'links#redirection', as: :redirect_url

  # api
  namespace :api do
    namespace :v1 do
      resources :links, only: [:show, :create]
      resources :users, only: [:show]
    end
  end

  root 'sessions#direct'
end
