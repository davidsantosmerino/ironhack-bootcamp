require "pry"

class SixDegrees

  def initialize twitter, user
    @twitter = twitter
    @user = user
  end

  def user_connections
      user_connection = UserConnection.new @twitter, @user
      user_connection.show_connections
  end

end
