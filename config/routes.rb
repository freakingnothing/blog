# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  namespace :auth do
    resources :users, only: %i[create show]
  end

  get '/signup' => 'auth/users#new'
  post '/signup' => 'auth/users#create'

  get '/login' => 'auth/sessions#new'
  post '/login' => 'auth/sessions#create'
  delete '/logout' => 'auth/sessions#destroy'

  get '/:token/confirm_email/', to: 'auth/users#confirm_email', as: 'confirm_email'

  get '/draft' => 'posts#draft_posts'

  root 'posts#index'
end
