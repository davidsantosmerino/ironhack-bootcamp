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

    it "return truthy when the min bid is greater than 0" do
      product_params = {
        title: "Thing",
        description: "bla bla",
        deadline: 1.day.from_now,
        min_bid: 5
      }

      expect(owner.products.create(product_params)).to be_truthy
    end

    it "raise an error when title no provided" do
      product_invalid_params = {
        description: "bla bla",
        deadline: 1.day.from_now,
        min_bid: 1
      }
      expect do
        (owner.products.create!(product_invalid_params))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "raise an error when min_bid no provided" do
      product_invalid_params = {
        title: "Thing",
        description: "bla bla",
        deadline: 1.day.from_now
      }
      expect do
        (owner.products.create!(product_invalid_params))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "raise an error when deadline no provided" do
      product_invalid_params = {
        title: "Thing",
        description: "bla bla",
        min_bid: 1
      }
      expect do
        (owner.products.create!(product_invalid_params))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

  end
end
