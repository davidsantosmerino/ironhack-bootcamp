class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :products
  has_many :bids

  def available_products
    Product.where.not("user_id = ?", self.id)
  end

  def own_products
    self.products
  end

  def bid_products
    bids = Bid.where("user_id = ?", self.id)
    products_bids = bids.map {|bid| bid.product_id}.uniq

    Product.where("id = ?", products_bids)
  end

  def won_products
    products = Product.all
    products.select{|product| product.winning_bider == self.id }
  end

end
