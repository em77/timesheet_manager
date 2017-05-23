Rails.application.routes.draw do
  get 'password_resets/create'

  get 'password_resets/edit'

  get 'password_resets/update'

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
  resources :pay_periods, only: :update
  resources :password_resets

  get "login" => "user_sessions#new", as: :login
  get "logout" => "user_sessions#destroy", as: :logout

  get "/approve_timesheet" => "timesheets#toggle_approved",
    as: "approve_timesheet"

  get "/change_user_active_status" => "users#change_active_status",
    as: "change_user_active_status"

  get "/change_job_active_status" => "jobs#change_active_status",
    as: "change_job_active_status"

  get "/change_company_active_status" => "companies#change_active_status",
    as: "change_company_active_status"

  root to: "pages#home"
end
