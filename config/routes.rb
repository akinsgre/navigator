Navigator::Application.routes.draw do

  get "sponsors/info"

  post "email/create"
  get "profile/edit"
  match  "groups/:id/join", :to => "groups#join", :via => :get
  match "groups/remove_contact", :to => "groups#remove_contact", :via => :put

  match "incoming_message", :to => "incoming_message#index"

  post "messages/deliver"
  get "home/index"
  get "donate/new"

  #devise_for :users
  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :users do
    resources :groups 
  end

  resources :groups do
    resources :contacts 
  end

  resources :groups do
    resources :sponsors
  end

  resources :subscriptions
  resources :contacts
  resources :messages
  resources :contact_types

  root :to => "home#index"

end
