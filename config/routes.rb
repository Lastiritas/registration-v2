Rails.application.routes.draw do

  root 'sessions#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :submissions,         only: [:index, :new, :create]
  resources :parents,             except: [:destroy]
  resources :campers,             except: [:index, :show]
  resources :registration_carts,  only: [:show, :destroy]
  resources :camp_sessions
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  get 'registration/index', as: 'registration_index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
