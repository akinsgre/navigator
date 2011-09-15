Navigator::Application.routes.draw do
  resources :groups

  root :to => "groups#index"


end
