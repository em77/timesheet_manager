Rails.application.routes.draw do
  resources :user_sessions

  root to: "pages#home"
end
