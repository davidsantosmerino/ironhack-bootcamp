Rails.application.routes.draw do

  get "/users" => "users#index"
  get "/users/new" => "users#new"
  get "/users/:user_id" => "users#show"
  post "/users" => "users#create"

  get "/users/:user_id/products" => "products#index"
  get "/users/:user_id/products/new" => "products#new"
  get "/users/:user_id/products/:product_id" => "products#show"
  post "/users/:user_id/products" => "products#create",
    as: :user_products

end
