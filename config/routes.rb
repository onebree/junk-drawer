Rails.application.routes.draw do
  root "home#index"

  get "/" => "home#index", :as => :home

  get 'saved_things/search'

  get "/auth/logout" => "sessions#destroy", :as => :logout
  get "/auth/failure" => "sessions#failure"
  match "/auth/:provider/callback" => "sessions#create", :via => [:get, :post]
  
  resources :saved_things, :only => [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
