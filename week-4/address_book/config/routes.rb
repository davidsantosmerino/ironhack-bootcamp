Rails.application.routes.draw do

  get "/contacts" => "contacts#index"

  get "/contacts/new" => "contacts#new"

  get "/contacts/search" => "contacts#search"

  get "/contacts/fav/:id" => "contacts#mark_as_fav"

  post "/contacts/create" => "contacts#create"

end
