Rails.application.routes.draw do
  resources :super_tokens
  resources :users

  get "/profile", to: "super_tokens#profile" 
  post "/login", to: "super_tokens#login" 

end
