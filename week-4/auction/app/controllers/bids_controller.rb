class BidsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @product = Product.find(params[:product_id])
    @bid = @product.bids.new
  end

  def create
    @user = User.find(params[:user_id])
    @product = Product.find(params[:product_id])
    @bid = @product.bids.new(bid_params)
    if @bid.save
      redirect_to "/users/#{@user.id}/products/#{@product.id}"
    end
  end

  private
  def bid_params
    params.require(:bid).permit(:amount,:product_id,:user_id)
  end

end
