class ProductsController < ApplicationController

  def index
    user = User.find_by(current_user_id)
    @available_products = user.available_products
    @own_products = user.own_products
    @bid_products = user.bid_products
    @won_products = user.won_products
  end

  def show
    @product = Product.find(params[:id])
    @time_left = ((@product.deadline - DateTime.now)/ 1.hour).round
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
    redirect_to products_path(@user)
  end

  private
  def product_params
    params.require(:product).permit(:title,:description,:deadline,:min_bid)
  end
end
