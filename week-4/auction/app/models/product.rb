class Product < ActiveRecord::Base
  belongs_to :user
  has_many :bids
  validates :title, presence: true
  validate :check_deadline
  validates :min_bid, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def expired
    self.deadline < DateTime.now
  end

  def winning_bider
    return nil unless self.bids.any?

    self.bids.order("amount DESC").first
  end

  private

  def valid_deadline?
    return false if self.deadline.nil?
    self.deadline > DateTime.now
  end

  def check_deadline
    errors.add(:deadline, "Deadline can't be before the current moment") unless valid_deadline?
  end

end
