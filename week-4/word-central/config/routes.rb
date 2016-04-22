Rails.application.routes.draw do

  get "/" => "site#home"

  #TextInspectionController
  get "/text_inspection/new" => "text_inspection#new"

  post "text_inspection/count" => "text_inspection#count"

  #AsciisController
  get "/asciis/new" => "asciis#new"

  post "/asciis/create" => "asciis#create"

  #QuotesController
  get "/quotes/new" => "quotes#new"

  post "/quotes/create" => "quotes#create"

end
