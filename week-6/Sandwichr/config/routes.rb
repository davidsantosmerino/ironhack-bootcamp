Rails.application.routes.draw do
  namespace :api do
    resources :sandwiches, except: [:new, :edit]
  end
end
