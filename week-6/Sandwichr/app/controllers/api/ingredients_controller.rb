class Api::IngredientsController < ApplicationController
  before_action :ensure_ingredient, only:[:show, :update, :destroy]
  def index
    ingredients = Ingredient.all
    render json: ingredients
  end
  def show
    render json: @ingredient
  end
  def create
    ingredient = Ingredient.new(ingredient_params)
    if ingredient.save
      render json: ingredient, status: :created
    else
      render json: { errors: ingredient.errors.full_messages }, status: 422
    end
  end
  def update
    if @ingredient.update(ingredient_params)
      render json: @ingredient, status: :ok
    else
      render json: { errors: @ingredient.errors.full_messages }, status: 422
    end
  end
  def destroy
     render json: @ingredient.destroy
  end

  private
  def ingredient_params
    params.require(:ingredient).permit(:name, :calories, :amount)
  end
  def ensure_ingredient
    @ingredient = Ingredient.find_by(id: params[:id])
    render(
      json: { errors: "Ingredient with id #{params[:id]} not found" },
      status: 404
    ) unless @ingredient
  end
end
