require 'test_helper'

RSpec.describe Product, type: :model do
  describe "#create" do
    subject(:owner) {
      User.create(
        email: "owner@example.com",
        password: "aaaaaa",
        password_confirmation: "aaaaaa"
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
    subject(:bidder) {
      User.create(
        email: "bidder@example.com",
        password: "aaaaaa",
        password_confirmation: "aaaaaa"
      )
    }

    it "return truthy when the amount is more than the min product bid" do
      expect(bidder.bids.create!(product_id: product.id, amount: 6)).to be_truthy
    end

    it "raise an error when the amount is less than the min product bid" do
      expect do
        (bidder.bids.create!(product_id: product.id, amount: 2))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "raise an error when the amount is less than 0" do
      expect do
        (bidder.bids.create!(product_id: product.id, amount: -2))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "raise an error when the bidder and the owner are the same user" do
      expect do
        (owner.bids.create!(product_id: product.id, amount: 8))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

  end
end
