class BidsController < ApplicationController

  def new
    @user = User.find(current_user_id)
    @product = Product.find(params[:product_id])
    @bid = @product.bids.new
  end

  def create
    @user = User.find(current_user_id)
    @product = Product.find(params[:product_id])
    @bid = @product.bids.new(bid_params)
    if @bid.save
      flash[:notice] = "Bid sended successfully"
      redirect_to "/products/#{@product.id}"
    else
      render "new"
    end
  end

  private
  def bid_params
    params.require(:bid).permit(:amount,:product_id,:user_id)
  end

end
