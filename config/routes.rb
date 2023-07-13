Rails.application.routes.draw do
  devise_for :views
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users

  root 'items#index'
end
