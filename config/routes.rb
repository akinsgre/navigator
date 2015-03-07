Navigator::Application.routes.draw do
  resources :help

  get 'auth/facebook/callback', :to => 'facebook#callback'
  get 'facebook/groups', :to => 'facebook#groups'
  post 'facebook/refresh', :to => 'facebook#refresh'
  post 'invites/create', :to => 'invites#create'


  devise_for :admins
  get "incoming_message/receive"

  post "email/create"
  get "email/show"
  get "profile/edit"
  get "groups/:id/add_contact", :to => 'groups#add_contact'
  post "/groups/:group_id/add_admin", :to => 'groups#add_admin'

  get "groups/remove_contact", :to =>  "groups#remove_contact"
  get "contacts/opt_out/:contact_id", :to =>  "contacts#opt_out", as: "contact_opt_out"
  get "contacts/verify_email/:token", :to =>  "contacts#verify_email", as: "contact_verify"
  post "contacts/verify_phone/:token", :to =>  "contacts#verify_phone", as: "contact_verify_phone"
  get "contacts/send_verification", :to =>  "contacts#send_verification", as: "contact_send_verification"
  get "contacts/find_for_verification", :to =>  "contacts#find_for_verification", as: "contact_find_for_verification"
  get "incoming_message", :to => "incoming_message#index"
  get "contacts/search", :to => "contacts#search"
  post "contacts/assign", :to => "contacts#assign"

  get "home/index"
  get "donate/new"

  #devise_for :users
  devise_for :users, :controllers => { :registrations => "registrations" }

  match "users/sign_out" => "users#sign_out", :via => :get
  get "users/setup", :to => "users#setup"

  get 'contact_type/:id', :to => 'contact_type#show'

  resources :users do
    resources :groups do
      post 'facebook/post', :to => 'facebook#post'
    end
    resources :contacts    
    resources :subscriptions
  end

  resources :subscriptions

  resources :sponsors do
    resources :advertisements
  end
  post 'contacts/create', :to => "contacts#create", as: "contacts"
  resources :groups do
    post 'facebook/post', :to => 'facebook#post'
    get "contact/edit", as: "sm"
    get "contact/edit", as: "phone"
    get "messages/new"
    get "messages/:id", to: "messages#show"
    post "messages/deliver"
    resources :contacts
  end


  resources :messages


  root :to => "home#index"



end

