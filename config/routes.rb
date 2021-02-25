Rails.application.routes.draw do
  get "/" => "home#top"
  post "/login" => "users#login"
  post "/logout" => "users#logout"
  
  post "/users/update/:id" => "users#update"
  post "/users/update_password/:id" => "users#update_password"
  get "/users/sign_in" => "users#sign_in"
  get "/users/sign_up" => "users#sign_up"
  get "/users/account/:id" => "users#account"
  get "/users/profile/:id" => "users#profile"
  get "/users/edit/:id" => "users#edit"
  get "/signup" => "users#new"
  
  post "/rooms/create" => "rooms#create"
  get "/rooms" => "rooms#search"
  get "/rooms/new" => "rooms#new"
  get "/rooms/posts" => "rooms#posts"
  get "/rooms/:id" => "rooms#reserve"
  
  post "/reservation/confirm" => "reservations#confirm"
  post "/reservation/create" => "reservations#create"
  get "/reservation/:id" => "reservations#posts"
  get "/reservations" => "reservations#index"
end
