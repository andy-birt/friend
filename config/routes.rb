Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  authenticated :user do
    root to: "static_pages#home", as: :authenticated_root
  end

  root to: redirect('/users/sign_in')

  resources :users 
  resources :friend_requests, only: [:create] do
    delete :destroy, on: :collection
  end

end
