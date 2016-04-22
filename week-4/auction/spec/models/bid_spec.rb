require 'test_helper'

RSpec.describe Bid, type: :model do
  describe "#create" do
    subject(:owner) {
      User.create(
        name: "owner",
        email: "owner@example.com"
      )
    }
    subject(:product) {
      owner.products.create(
        title: "Thing",
        description: "bla bla",
        deadline: 1.day.from_now,
        min_bid: 5
      )
    }
    subject(:bidder) { User.create(name: "bidder", email: "bidder@example.com") }

    it "return truthy when the amount is more than the min product bid" do
      expect(bidder.bids.create(product_id: product.id, amount: 6)).to be_truthy
    end

    it "raise an error when the amount is less than the min product bid" do
      expect do
        (bidder.bids.create(product_id: product.id, amount: 2))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

  end
end
