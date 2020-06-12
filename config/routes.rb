Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    shared: "users/shared"
  }
  
  authenticated :user do
    root to: "posts#index", as: :authenticated_root
  end
  
  devise_scope :user do
    root to: "users/registrations#new"
  end
  
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
    end
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
