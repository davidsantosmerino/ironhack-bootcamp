Rails.application.routes.draw do
  namespace :api do
    resources :sandwiches, only: [:index, :show, :create, :update, :destroy] do
      member do
        get "/details" => :details
      end
    end

    resources :ingredients, only: [:index, :show, :create, :update, :destroy]
  end
end
