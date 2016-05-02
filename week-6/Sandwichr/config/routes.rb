Rails.application.routes.draw do
  namespace :api do
    resources :sandwiches, only: [:index, :show, :create, :update, :destroy] do
      member do
        get "/details" => :details
        post "/ingredients/add" => :add_ingredients
      end
    end

    resources :ingredients, only: [:index, :show, :create, :update, :destroy]
  end
end
