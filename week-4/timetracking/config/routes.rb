Rails.application.routes.draw do

  get "/projects" => "projects#index"

  get "/projects/new" => "projects#new"

  get "/projects/:project_id" => "projects#show"

  post "/projects" => "projects#create"


  get "/projects/:project_id/time_entries" => "time_entry#index",
    as: :project_time_entries

  get "/projects/:project_id/time_entries/new" => "time_entry#new"

  post "/projects/:project_id/time_entries" => "time_entry#create"
end
