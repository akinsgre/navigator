Navigator::Application.routes.draw do

  get "sponsors/info"

  post "email/create"
  get "profile/edit"
  get "groups/:id/add_contact", :to => 'groups#add_contact'
  post "groups/save_contact", :to => "groups#save_contact"
  match "groups/remove_contact" => "groups#remove_contact", :via => :get 
  
  match "incoming_message" => "incoming_message#index", :via => :get

  post "messages/deliver"
  get "home/index"
  get "donate/new"

  #devise_for :users
  devise_for :users, :controllers => { :registrations => "registrations" }

  match "users/sign_out" => "users#sign_out", :via => :get

  resources :users do
    resources :groups
    resources :contacts
    resources :subscriptions
  end

  resources :subscriptions

  resources :groups do
    resources :contacts
  end


  resources :messages


  root :to => "home#index"



end

