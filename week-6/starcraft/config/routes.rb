Rails.application.routes.draw do
  namespace :api do
    resources :matches, only: [:index]
  end
end
