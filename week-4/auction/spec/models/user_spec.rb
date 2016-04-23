require 'test_helper'

RSpec.describe User, type: :model do
  describe "#create" do
    user_params = {
        :email => "owner@example.com",
        :password => "aaaaaa",
        :password_confirmation => "aaaaaa"
    }

    it "return truthy when the mandatory params are provided" do
      expect(User.create(user_params)).to be_truthy
    end
    
  end
end
