require 'rails_helper'

RSpec.describe Sandwich, type: :model do
  let!(:tuna_sandwich) { Sandwich.create!(name: "Tuna", bread_type: "rye") }

  let(:sandwich_params) {
    sandwich = {}
    sandwich[:name] = new_name
    sandwich
  }

  describe "#create" do
    context "with valid data" do
      let(:new_name) { "bacon" }

      it "save the Sandwich to the database" do
        expect(Sandwich.create!(sandwich_params)).to be_truthy
      end
    end
    context "with invalid data" do
      let(:new_name) { "ab" }

      it "return an error message 'Name is too short...'" do
        sandwich = Sandwich.new(sandwich_params)
        sandwich.save
        expect(sandwich.errors.full_messages)
          .to include("Name is too short (minimum is 3 characters)")
      end

      it "does not create an object in the database" do
        expect { Sandwich.create(sandwich_params) }
          .to_not change{Sandwich.count}
      end
    end
  end
  describe "#update" do
    context "with valid data" do
      let(:new_name) { "tuna tuna" }
      it "update the Sandwich to the database" do
        expect(tuna_sandwich.update(sandwich_params)).to be_truthy
      end
    end
    context "with invalid data" do
      let(:new_name) { "ab" }

      it "return an error message 'Name is too short...'" do
        tuna_sandwich.update(sandwich_params)
        expect(tuna_sandwich.errors.full_messages)
          .to include("Name is too short (minimum is 3 characters)")
      end
    end
  end
end
