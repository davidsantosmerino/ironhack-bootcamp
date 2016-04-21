Rails.application.routes.draw do

  resources(:users) do
   resources(:products) do
     resources(:bids, only: [:index, :new, :create])
   end
 end

  # get "/users" => "users#index"
  # get "/users/new" => "users#new"
  # get "/users/:user_id" => "users#show"
  # post "/users" => "users#create"
  #
  # get "/users/:user_id/products" => "products#index"
  # get "/users/:user_id/products/new" => "products#new"
  # get "/users/:user_id/products/:product_id" => "products#show",
  #   as: :user_product
  # get "/users/:user_id/products/:product_id/edit" => "products#edit"
  # post "/users/:user_id/products" => "products#create",
  #   as: :user_products
  # patch "/users/:user_id/products/:product_id/edit" => "products#update"
  # delete "/users/:user_id/products/:product_id" => "products#destroy"
  #
  # get "/users/:user_id/products/:product_id/bids/new" => "bids#new"
  # post "/users/:user_id/products/:product_id/bids" => "bids#create",
  #   as: :user_product_bids

end
