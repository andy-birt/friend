Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  authenticated :user do
    root to: "static_pages#home", as: :authenticated_root
  end

  root to: redirect('/users/sign_in')

end
