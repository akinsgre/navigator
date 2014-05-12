Navigator::Application.routes.draw do

  get "sponsors/info"

  post "email/create"
  get "profile/edit"
  match "groups/remove_contact" => "groups#remove_contact", :via => :get 
  
  match "incoming_message" => "incoming_message#index", :via => :get

  post "messages/deliver"
  get "home/index"
  get "donate/new"

  #devise_for :users
  devise_for :users, :controllers => { :registrations => "registrations" }

  match "users/sign_out" => "users#sign_out", :via => :get

  resources :users
  resources :groups
  # resources :subscriptions
  # resources :contacts
  # resources :messages
  # resources :contact_types

  root :to => "home#index"

end
