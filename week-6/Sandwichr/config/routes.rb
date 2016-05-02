Rails.application.routes.draw do
  namespace :api do
    resources :sandwiches, only: [:index, :show, :create, :update, :destroy]
    resources :ingredients, only: [:index, :show, :create, :update, :destroy]
  end
end
