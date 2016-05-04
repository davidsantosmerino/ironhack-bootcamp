Rails.application.routes.draw do
  namespace :api do
    resources :matches, only: [:index] do
      collection do
        get ':faction' => :by_faction
      end
    end
    resources :players, only: [:show]
  end
end
