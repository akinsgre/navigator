Navigator::Application.routes.draw do

  get "incoming_message/receive"
  get "twiml/say"
  get "sponsors/info"

  post "email/create"
  get "email/show"
  get "profile/edit"
  get "groups/:id/add_contact", :to => 'groups#add_contact'
  post "groups/save_contact", :to => "groups#save_contact"
  get "groups/remove_contact", :to =>  "groups#remove_contact"
  
  get "incoming_message", :to => "incoming_message#index"


  get "home/index"
  get "donate/new"

  #devise_for :users
  devise_for :users, :controllers => { :registrations => "registrations" }

  match "users/sign_out" => "users#sign_out", :via => :get
  get 'contact_type/:id', :to => 'contact_type#show'
  resources :contacts do
    get "opt_out"
  end
  resources :users do
    resources :groups
    resources :contacts
    resources :subscriptions
  end

  resources :subscriptions

  resources :groups do
    get "messages/new"
    post "messages/deliver"
    resources :contacts
  end


  resources :messages


  root :to => "home#index"



end

