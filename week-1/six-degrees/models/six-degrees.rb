Dir["./models/*"].each {|file| require file }
require "pry"

class SixDegrees
  attr_reader :users, :tweets

  def initialize input = "input.txt"
    @users = []
    @tweets = []
    parse_input input
  end

  def parse_input input
    input = IO.readlines input
    input.each do |line|
      line_content = line.split ": "
      name = line_content[0]
      message = line_content[1]
      user = add_user name
      add_tweet user, message
    end
  end

  def add_tweet user, message
    @tweets << Tweet.new(user, message)
  end

  def get_user name
    @users.find { |user| user.name == name  }
  end

  def add_user name
    if !user_exists? name
      @users << User.new(name)
    end

    get_user name
  end

  def user_exists? name
    @users.any? { |user| user.name == name  }
  end

  def show_users
    @users.each { |user| user.name  }
  end

  def show_tweets
    @tweets.each { |tweet| tweet.show  }
  end

  def user_connections
    user_connection = UserConnection.new @users, @tweets
  end

end
