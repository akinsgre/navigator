Navigator::Application.routes.draw do


  post "email/create"

  get "profile/edit"
  match "groups/remove_contact", :to => "groups#remove_contact"
  
  match "incoming_message", :to => "incoming_message#index"
  post "messages/deliver"
  get "home/index"
  #devise_for :users
  devise_for :users, :controllers => { :registrations => "registrations" }
  match "users/sign_out", :to => "users#sign_out", :via => "get"

  resources :users
  resources :groups
  resources :subscriptions
  resources :contacts
  resources :messages
  resources :contact_types

  root :to => "home#index"

end
