Rails.application.routes.draw do
  resources :site, only:[:index], path: "/"
  resources :concerts
end
