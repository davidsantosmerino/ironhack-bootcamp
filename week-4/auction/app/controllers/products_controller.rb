class ProductsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @products = Product.order(created_at: :desc)
  end
  def show
    @product = Product.find(params[:product_id])
  end
  def new
    @user = User.find(params[:user_id])
    @product = @user.products.new
  end
  def create
    @user = User.find(params[:user_id])
    @product = @user.products.new(product_params)
    if @product.save
      redirect_to "/users/#{@user.id}/products/#{@product.id}"
    end
  end

  private
  def product_params
    params.require(:product).permit(:title,:description,:deadline)
  end
end
