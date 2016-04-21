class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def user_name
    user = User.find(self.user_id)
    user.name
  end
end
