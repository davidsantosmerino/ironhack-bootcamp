require "sinatra"
require "sinatra/reloader"
require "./libs/calculator"

get "/" do
  erb(:welcome)
end

get "/calculator" do
  erb(:calculator)
end

post "/calculate" do
  first = params[:first_number].to_f
  second = params[:second_number].to_f
  operation = params[:operation]
  case operation
  when "add"
    result = Calculator.add first, second
  when "substract"
    result = Calculator.substract first, second
  when "multiply"
    result = Calculator.multiply first, second
  when "divide"
    result = Calculator.divide first, second
  end
  "The result of #{operation} #{first} and #{second} is #{result}"
end

get "/add" do
  erb(:add)
end
get "/substract" do
  erb(:substract)
end
get "/multiply" do
  erb(:multiply)
end
get "/divide" do
  erb(:divide)
end

post "/calculate_add" do
  first = params[:first_number].to_f
  second = params[:second_number].to_f
  result = Calculator.sum first, second
  "The addition of #{first} and #{second} is #{result}"
end

post "/calculate_substract" do
  first = params[:first_number].to_f
  second = params[:second_number].to_f
  result = Calculator.substract first, second
  "The substraction of #{first} and #{second} is #{result}"
end

post "/calculate_multiply" do
  first = params[:first_number].to_f
  second = params[:second_number].to_f
  result = Calculator.multiply first, second
  "The multiplication of #{first} and #{second} is #{result}"
end

post "/calculate_divide" do
  first = params[:first_number].to_f
  second = params[:second_number].to_f
  result = Calculator.divide first, second
  "The divition of #{first} and #{second} is #{result}"
end
