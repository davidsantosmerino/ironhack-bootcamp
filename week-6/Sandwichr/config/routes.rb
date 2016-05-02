Rails.application.routes.draw do
  namespace :api do
    resources :sandwiches, only: [:index, :show, :create, :update]
  end
end
