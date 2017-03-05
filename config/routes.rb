Rails.application.routes.draw do
  resources :submissions, only: [:index, :new, :create]
  resources :parents, except: [:destroy]
  resources :campers, except: [:index, :show]
  resources :registration_carts, only: [:show, :destroy]
  resources :camp_sessions

  get 'registration/index', as: 'registration_index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
