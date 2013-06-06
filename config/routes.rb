Gedesh::Application.routes.draw do
  match "/auth/:provider/callback", :to => "sessions#create"
  match "/auth/failure", :to => "sessions#failure"
  match '/auth/identity', :to => 'sessions#new', :as => :signin_form
  match "/signout", :to => "sessions#destroy", :as => "signout"

  mount Doorkeeper::Engine => '/oauth'

  match "/oauth/user", to: "users#show"

  resources :passwords,  :except => [:index, :show, :destroy]
end
