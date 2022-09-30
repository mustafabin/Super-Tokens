Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  get "/profile", to: "users#profile" 
  post "/login", to: "users#login" 
  # root "articles#index"
end
