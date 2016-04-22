class ProductsManagementController < ApplicationController

  def index
    user = User.find(params[:user_id])
    @own_products = user.own_products
    @bid_products = user.bid_products
    @won_products = user.won_products
  end
end
