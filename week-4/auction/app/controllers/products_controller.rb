class ProductsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @products = Product.order(created_at: :desc)
  end
  def show
    @user = User.find(params[:user_id])
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
  def edit
    @user = User.find(params[:user_id])
    @product = @user.products.find(params[:product_id])
  end
  def update
    @user = User.find(params[:user_id])
    @product = @user.products.find(params[:product_id])
    @product.update(product_params)
    if @product.save
      redirect_to "/users/#{@user.id}/products/#{@product.id}"
    end
  end
  def destroy
    @product = Product.find(params[:product_id])
  end

  private
  def product_params
    params.require(:product).permit(:title,:description,:deadline)
  end
end
