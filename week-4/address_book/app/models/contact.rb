class Contact < ActiveRecord::Base
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, format:{ with: /(?:\+?|\b)[0-9]{9,12}\b/, message: "%{value} is not a valid phone number."}
  validates :email, uniqueness: true, format:{ with: /\b[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\b/, message: "%{value} is not a valid email."}
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
