Navigator::Application.routes.draw do
  devise_for :users

  resources :groups
  resources :contacts

  root :to => "groups#index"


end
