class BidsController < ApplicationController

  def create
    @user = User.find(current_user)
    @product = Product.find(params[:product_id])
    @bid = @user.bids.new(product_id: params[:product_id], amount: bid_params[:amount])
    if @bid.save
      flash[:notice] = "Bid sended successfully"
    end
    redirect_to product_path(@product)
  end

  private
  def bid_params
    params.require(:bid).permit(:amount)
  end

end
