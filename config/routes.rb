Navigator::Application.routes.draw do
  devise_for :users

  resources :groups
  resources :contacts
  resources :users

  root :to => "groups#index"


end
