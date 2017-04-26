Rails.application.routes.draw do
  root "home#index"

  get "/" => "home#index", :as => :home
  
  get "/collect" => "saved_things#collect", :as => :collect_saved_things

  get "/logout"   => "sessions#destroy",  :as => :logout
  get "/redirect" => "sessions#redirect", :as => :redirect
  
  resources :saved_things, :only => [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end