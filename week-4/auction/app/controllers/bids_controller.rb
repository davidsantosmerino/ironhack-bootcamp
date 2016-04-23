class BidsController < ApplicationController

  def create
    @user = User.find(current_user)
    @product = Product.find(params[:product_id])
    @bid = @product.bids.new(bid_params)
    if @bid.save
      flash[:notice] = "Bid sended successfully"
    end
    redirect_to product_path(@product)
  end

  private
  def bid_params
    params.require(:bid).permit(:amount,:product_id,:user_id)
  end

end
