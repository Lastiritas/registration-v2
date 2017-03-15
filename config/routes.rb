Rails.application.routes.draw do

  root 'sessions#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    'auth/:provider/callback', to: 'sessions#create'
  get    'auth/failure', to: 'sessions#new'
  get    'admin',    to: 'admin#index', as: :admin_index
  get    'admin/registrations', to: 'admin#registrations', as: :admin_registrations
  get    'camp_sessions/:gender', to: 'camp_sessions#sessions_by_gender', as: :sessions_by_gender

  resources :users
  resources :submissions,         only: [:new, :create]
  resources :parents,             except: [:destroy]
  resources :campers,             except: [:index, :show]
  resources :registration_carts,  only: [:show, :destroy]
  resources :camp_sessions
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  get 'registration/index', as: 'registration_index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
