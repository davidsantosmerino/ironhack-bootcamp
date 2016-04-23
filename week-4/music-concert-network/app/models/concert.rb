class Concert < ActiveRecord::Base
  validates :artist, presence: true
  validates :venue, presence: true
  validates :city, presence: true
  validates :date, presence: true
  validates :price, presence: true, numericality: true
  validates :description, presence: true
end
