require "./models/user-connection"

class User
  attr_reader :name

  def initialize name
    @name = name
  end

  def search_connections tweets
    user_connection = UserConnection.new @name, tweets
    user_connection.show_connections
  end

end
