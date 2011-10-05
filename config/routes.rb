Navigator::Application.routes.draw do

  post "messages/deliver"
  get "home/index"

  resources :messages

  devise_for :users
  match "users", :to => "users#index", :via => "get"
  resources :users

  resources :groups
  resources :subscriptions
  resources :contacts

  root :to => "home#index"

  match "incoming_message", :to => "incoming_message#index"


end
