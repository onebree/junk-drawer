Rails.application.routes.draw do
  root "home#index"

  get "/" => "home#index", :as => :home
  
  get "/collect" => "saved_things#collect", :as => :collect_saved_things

  get "/auth/logout"   => "sessions#destroy",  :as => :logout
  get "/auth/failure"  => "sessions#failure",  :as => :failure
  get "/redirect" => "sessions#redirect", :as => :redirect
  
  resources :saved_things, :only => [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end