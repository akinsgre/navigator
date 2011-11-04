Navigator::Application.routes.draw do

  get "contact_types/index"

  get "contact_types/show"

  get "contact_types/new"

  get "contact_types/create"

  get "contact_types/update"

  get "contact_types/destroy"

  get "contact_type/index"

  get "contact_type/show"

  get "contact_type/new"

  get "contact_type/create"

  get "contact_type/update"

  get "contact_type/destroy"

   post "email/create"

   get "profile/edit"
   match "groups/remove_contact", :to => "groups#remove_contact"
   match "users", :to => "users#index", :via => "get"
   match "incoming_message", :to => "incoming_message#index"
   post "messages/deliver"
   get "home/index"
   devise_for :users, :controllers => { :registrations => "registrations" }
 #  devise_for :users

   resources :users
    resources :groups
    resources :subscriptions
    resources :contacts
  resources :messages
  resources :contact_types

   root :to => "home#index"

end
