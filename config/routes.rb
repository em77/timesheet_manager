Rails.application.routes.draw do
  resources :messages do
    get :autocomplete_user_full_name, on: :collection
  end

  resources :jobs do
    get :autocomplete_user_full_name, on: :collection
  end
  
  resources :user_sessions
  resources :messages
  resources :users
  resources :companies
  resources :jobs
  resources :timesheets

  get "login" => "user_sessions#new", as: :login
  get "logout" => "user_sessions#destroy", as: :logout

  get "/approve_timesheet" => "timesheets#toggle_approved",
    as: "approve_timesheet"

  root to: "pages#home"
end
