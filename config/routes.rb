Rails.application.routes.draw do
  resources :groups
  resources :group_users
  resources :webs
  resources :companies
  resources :logs

## Users
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords" }
  devise_scope :user do
     post "/signup", to: "users/registrations#create"
     post "/login", to:"users/sessions#create" # Para obtener el token de inicio de sesión
  end

  get "users/index", to:"users#index", as: :users
  post "users/create", to:"users#create", as: :create_user
  get "users/new", to:"users#new", as: :new_user
  get "users/edit/:id", to:"users#edit", as: :edit_user
  get "users/show/:id", to:"users#show", as: :show_user
  patch "users/update/:id", to:"users#update", as: :update_user
  put "users/update/:id/password", to:"users#change_password", as: :change_user_password
  delete "users/delete/:id", to:"users#destroy", as: :delete_user

  get "admin/index"
  get :logout, to: "users#logout", as: :logout


## Web companies
  get "subscriptions/ransack", to: "subscriptions#ransack", as: :ransack_subscriptions
  resources :subscriptions


## Web companies
  get "web_companies/ransack", to: "web_companies#ransack", as: :ransack_web_companies
  resources :web_companies


## Credentials
  ### API
  get "api/me/credentials", to: "credentials#api_credentials"
  get "api/me/credentials/:id", to: "credentials#api_credential"
  put "api/me/credentials/:id", to: "credentials#api_change_credential_password"

  resources :credentials


## Tags
  get "tags/ransack", to: "tags#ransack", as: :ransack_tags
  resources :tags


## Emergency contacts
  get "emergency_contacts/requests", to: "emergency_contacts#requests", as: :emergency_requests
  post "emergency_contacts/:id/requests", to: "emergency_contacts#emergency_request", as: :add_emergency_request
  resources :emergency_contacts


## General
  root to: "admin#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
