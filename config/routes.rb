Rails.application.routes.draw do
  resources :logs

  get 'users/index', to:'users#index', as: :users
  post 'users/create', to:'users#create', as: :create_user
  get 'users/new', to:'users#new', as: :new_user
  get 'users/edit/:id', to:'users#edit', as: :edit_user
  get 'users/show/:id', to:'users#show', as: :show_user
  patch 'users/update/:id', to:'users#update', as: :update_user
  delete 'users/delete/:id', to:'users#destroy', as: :delete_user

  get 'admin/index'
  ## Users
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' }
    devise_scope :user do
       post '/signup', to: 'users/registrations#create'
       post '/login', to:'users/sessions#create' # Para obtener el token de inicio de sesión
    end


  get :logout, to: 'users#logout', as: :logout

  root to: 'admin#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
