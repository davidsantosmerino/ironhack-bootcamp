class Api::SandwichesController < ApplicationController
  def index
    sandwiches = Sandwich.all
    render json: sandwiches
  end
  def show
    sandwich = Sandwich.find(params[:id])
    render json:sandwich
  end
end
