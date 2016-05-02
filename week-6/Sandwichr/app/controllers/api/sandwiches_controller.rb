class Api::SandwichesController < ApplicationController
  before_action :ensure_sandwich, only: [:show, :details, :update, :add_ingredients, :destroy]
  before_action :ensure_ingredient, only: [:add_ingredients]
  def index
    sandwiches = Sandwich.all
    render json: sandwiches
  end
  def show
    render json: @sandwich
  end
  def details
    render json: @sandwich.to_json({:include => :ingredients})
  end
  def create
    sandwich = Sandwich.new(sandwich_params)
    if sandwich.save
      render json: sandwich, status: :created
    else
      render json: { errors: sandwich.errors.full_messages }, status: 422
    end
  end
  def update
    if @sandwich.update(sandwich_params)
      render json: @sandwich, status: :ok
    else
      render json: { errors: @sandwich.errors.full_messages }, status: 422
    end
  end
  def add_ingredients
    if @sandwich.ingredients.push(@ingredient)
      render json: @sandwich.to_json({:include => :ingredients})
    else
      render json: { errors: sandwich.errors.full_messages }, status: 422
    end
  end
  def destroy
     render json: @sandwich.destroy
  end

  private
  def sandwich_params
    params.require(:sandwich).permit(:name, :bread_type)
  end
  def ensure_sandwich
    @sandwich = Sandwich.find_by(id: params[:id])
    render(
      json: { errors: "Sandwich with id #{params[:id]} not found" },
      status: 404
    ) unless @sandwich
  end
  def ensure_ingredient
    @ingredient = Ingredient.find_by(id: params[:ingredient_id])
    render(
      json: { errors: "Ingredient with id #{params[:ingredient_id]} not found" },
      status: 404
    ) unless @ingredient
  end
end
