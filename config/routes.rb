Navigator::Application.routes.draw do



  resources :help

  get 'auth/facebook/callback', :to => 'facebook#callback'
  get 'facebook/groups', :to => 'facebook#groups'
  post 'facebook/refresh', :to => 'facebook#refresh'


  devise_for :admins
  get "incoming_message/receive"
  get "twiml/say"


  post "email/create"
  get "email/show"
  get "profile/edit"
  get "groups/:id/add_contact", :to => 'groups#add_contact'

  get "groups/remove_contact", :to =>  "groups#remove_contact"
  get "contacts/opt_out/:contact_id", :to =>  "contacts#opt_out", as: "contact_opt_out"
  get "incoming_message", :to => "incoming_message#index"


  get "home/index"
  get "donate/new"

  #devise_for :users
  devise_for :users, :controllers => { :registrations => "registrations" }

  match "users/sign_out" => "users#sign_out", :via => :get
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
  
  resources :groups do
    post 'facebook/post', :to => 'facebook#post'
    get "contact/edit", as: "sm"
    get "contact/edit", as: "phone"
    get "messages/new"
    post "messages/deliver"
    resources :contacts
  end


  resources :messages


  root :to => "home#index"



end

