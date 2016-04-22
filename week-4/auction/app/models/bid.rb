class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :check_enough_amount
  validate :check_bidder

  def user_name
    User.find(self.user_id).name
  end

  private

  def enough_amount?
    Product.find(self.product_id).min_bid <= self.amount
  end

  def check_enough_amount
    errors.add(:amount, "Not enough amount") unless enough_amount?
  end

  def valid_bidder?
    product = Product.find(self.product_id)
    product.user_id != self.user_id
  end

  def check_bidder
    errors.add(:bidder, "Not allowed shill bidding") unless valid_bidder?
  end
end
