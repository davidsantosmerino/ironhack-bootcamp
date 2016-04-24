class Concert < ActiveRecord::Base
  validates :artist, presence: true
  validates :venue, presence: true
  validates :city, presence: true
  validates :date, presence: true
  validates :price, presence: true, numericality: true
  validates :description, presence: true
  has_attached_file :asset, styles: { medium: "300x300>", thumb: "100x100>", small: "64X64>" }, default_url: "/assets/missing_:style.jpg"
  validates_attachment_content_type :asset, content_type: /\Aimage\/.*\Z/

  def self.today
    where("date = ?", Date.today)
  end

  def self.upcoming
    where("date > ?", Date.today)
  end

  def self.this_month
    upcoming.where("date <= ?", Date.today.end_of_month)
  end
end
