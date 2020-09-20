Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks",
    shared: "users/shared"
  }
  
  authenticated :user do
    root to: "posts#index", as: :authenticated_root
  end
  
  devise_scope :user do
    root to: "users/registrations#new"
  end

  concern :likable do |options|
    resources :likes, **options
  end
  
  concern :commentable do |options|
    resources :comments, **options do
      concerns :likable, module: :comments
    end
  end

  concern :posts do
    resources :posts do
      concerns :commentable, module: :posts
      concerns :likable, module: :posts
    end
  end
  
  resources :users do
    concerns :posts
  end

  resources :photos do
    concerns :commentable, module: :photos
    concerns :likable, module: :photos
  end

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  resources :friend_requests, only: [:create] do
    delete :destroy, on: :collection
  end

  get "/privacy-policy", to: "static#privacy_policy"

end