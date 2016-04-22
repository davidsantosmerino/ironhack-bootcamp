class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validate :check_enough_amount

  def user_name
    User.find(self.user_id).name
  end

  def enough_amount?
    Product.find(self.product_id).min_bid > self.amount
  end

  def check_enough_amount
    errors.add(:base, "Not enough amount") if enough_amount?
  end
end
