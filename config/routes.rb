Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
  
  authenticated :user do
    root to: "static_pages#home", as: :authenticated_root
  end
  
  devise_scope :user do
    root to: "users/registrations#new"
  end
  
  resources :users do
    resources :posts
  end

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  resources :friend_requests, only: [:create] do
    delete :destroy, on: :collection
  end

end
