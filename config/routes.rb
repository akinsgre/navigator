Navigator::Application.routes.draw do
  get "home/index"

  devise_for :users

  resources :groups
  resources :contacts
  resources :users

  root :to => "home#index"

  match "incoming_message", :to => "incoming_message#index"


end
