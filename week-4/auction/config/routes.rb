Rails.application.routes.draw do

  get "/" => "sessions#new"
  post "/" => "sessions#create"

  resources(:users) do
    resources(:products_management, only: [:index])
  end
  resources(:products) do
    resources(:bids, only: [:new, :create])
  end

end
