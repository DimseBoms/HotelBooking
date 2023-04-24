Rails.application.routes.draw do
  resources :reservations
  resources :hotels

  get "/search_results", to: "reservations#search_results"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "reservations#search"
end
