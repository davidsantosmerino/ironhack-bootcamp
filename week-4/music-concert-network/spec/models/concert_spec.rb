require 'rails_helper'

RSpec.describe Concert, type: :model do

  describe "#create" do
    it "return truthy when the all the mandatory fields are filled" do
      concert_params = {
        artist: "Marea",
        venue: "Parc del Forum",
        city: "Barcelona",
        date: 5.day.from_now,
        price: 20.50,
        description: "Marea is back, and again in Barcelona"
      }
      expect(Concert.create!(concert_params)).to be_truthy
    end
    it "raise an error when the artist is not filled" do
      concert_params = {
        venue: "Parc del Forum",
        city: "Barcelona",
        date: 5.day.from_now,
        price: 20.50,
        description: "Marea is back, and again in Barcelona"
      }
      expect do
        (Concert.create!(concert_params))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "raise an error when the venue is not filled" do
      concert_params = {
        artist: "Marea",
        city: "Barcelona",
        date: 5.day.from_now,
        price: 20.50,
        description: "Marea is back, and again in Barcelona"
      }
      expect do
        (Concert.create!(concert_params))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "raise an error when the city is not filled" do
      concert_params = {
        artist: "Marea",
        venue: "Parc del Forum",
        date: 5.day.from_now,
        price: 20.50,
        description: "Marea is back, and again in Barcelona"
      }
      expect do
        (Concert.create!(concert_params))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "raise an error when the date is not filled" do
      concert_params = {
        artist: "Marea",
        venue: "Parc del Forum",
        city: "Barcelona",
        price: 20.50,
        description: "Marea is back, and again in Barcelona"
      }
      expect do
        (Concert.create!(concert_params))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "raise an error when the price is not filled" do
      concert_params = {
        artist: "Marea",
        venue: "Parc del Forum",
        city: "Barcelona",
        date: 5.day.from_now,
        description: "Marea is back, and again in Barcelona"
      }
      expect do
        (Concert.create!(concert_params))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "raise an error when the description is not filled" do
      concert_params = {
        artist: "Marea",
        venue: "Parc del Forum",
        city: "Barcelona",
        date: 5.day.from_now,
        price: 20.50
      }
      expect do
        (Concert.create!(concert_params))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
