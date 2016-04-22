class Product < ActiveRecord::Base
  belongs_to :user
  has_many :bids
  validates :min_bid, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def expired
    self.deadline < DateTime.now
  end

  def winning_bider
    return nil unless self.bids.any?

    self.bids.order("amount DESC").first
  end

end
