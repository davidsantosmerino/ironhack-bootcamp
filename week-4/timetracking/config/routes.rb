Rails.application.routes.draw do

  get "/" => "projects#index"

  get "/projects/:id" => "projects#show"

  get "/projects/:project_id/time_entries" => "time_entry#index"

  get "/new" => "projects#new"

  post "/projects" => "projects#create"

end
