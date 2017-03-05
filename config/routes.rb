Rails.application.routes.draw do
  root "home#index"

  get "/auth/logout" => "sessions#destroy", :as => :logout
  match "/auth/:provider/callback" => "sessions#create", :via => [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
