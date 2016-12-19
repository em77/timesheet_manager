Rails.application.routes.draw do
  resources :user_sessions

  get "login" => "user_sessions#new", as: :login
  get "logout" => "user_sessions#destroy", as: :logout

  root to: "pages#home"
end
