Rails.application.routes.draw do
  
  get "/" => "sessions#new"
  post "/" => "sessions#create"

  resources(:users)
  resources(:products) do
    resources(:bids, only: [:index, :new, :create])
  end

end
