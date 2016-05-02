class Api::IngredientsController < ApplicationController
  before_action :ensure_ingredient, only:[:show]
  def index
    ingredients = Ingredient.all
    render json: ingredients
  end
  def show
    render json: @ingredient
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
