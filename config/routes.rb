Navigator::Application.routes.draw do

  match "groups/remove_contact", :to => "groups#remove_contact"
  match "users", :to => "users#index", :via => "get"
  match "incoming_message", :to => "incoming_message#index"

  post "messages/deliver"
  get "home/index"

  devise_for :users

  resources :users
  resources :groups
  resources :subscriptions
  resources :contacts
  resources :messages

  root :to => "home#index"

end
