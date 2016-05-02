Rails.application.routes.draw do
  resources :sandwiches, except: [:new, :edit]
end
