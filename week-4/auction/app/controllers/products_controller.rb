class ProductsController < ApplicationController

  def index
    @products = Product.order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @user = User.find(current_user_id)
    @product = @user.products.new
  end

  def create
    @user = User.find(current_user_id)
    @product = @user.products.new(product_params)
    if @product.save
      redirect_to "/products/#{@product.id}"
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    if @product.save
      redirect_to "/products/#{@product.id}"
    end
  end

  def destroy
    @user = User.find(current_user_id)
    @product = @user.products.find(params[:id])
    @product.destroy
    redirect_to user_products_path(@user)
  end

  private
  def product_params
    params.require(:product).permit(:title,:description,:deadline)
  end
end
