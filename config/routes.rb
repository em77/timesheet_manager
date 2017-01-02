Rails.application.routes.draw do
  resources :messages do
    get :autocomplete_user_full_name, on: :collection
  end
  
  resources :user_sessions
  resources :messages

  get "login" => "user_sessions#new", as: :login
  get "logout" => "user_sessions#destroy", as: :logout

  root to: "pages#home"
end
