Rails.application.routes.draw do

  get "/" => "site#home"

  get "/projects" => "projects#index"

  get "/contact" => "site#contact"

  get "/say_name/:name" => "site#say_name"

  get "/calculator" => "site#calculator"

  post "/calculate" => "site#calculate"

end
