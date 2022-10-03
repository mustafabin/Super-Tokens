Rails.application.routes.draw do
  resources :super_tokens
  resources :users

  get "/profile", to: "users#profile" 
  post "/login", to: "users#login" 

end
