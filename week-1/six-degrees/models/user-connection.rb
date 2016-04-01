class UserConnection

  def initialize users, tweets
    @users = users
    @tweets = tweets
    search_connections
  end

  def search_connections
    @users.each do |user|
      connections = get_direct_connections user.name
      show_connections user.name, connections
    end
  end

  def get_direct_connections user_name
    connections = []
    candidate_connections = []
    user_tweets = get_tweets_by_user user_name
    user_tweets.each do |tweet|
      tweet.mentions.each do |mention|
        candidate_connections << mention
      end
    end
    candidate_connections.uniq!

    candidate_connections.each do |candidate|
      if has_any_mention? candidate, user_name
        connections << candidate
      end
    end

    connections
  end

  def has_any_mention? candidate, user_name
    tweets = get_tweets_by_user candidate

    tweets.any? do |tweet|
      tweet.mentions.include? user_name
    end
  end

  def get_tweets_by_user user_name
    @tweets.select { |tweet| tweet.user.name == user_name  }
  end

  def show_connections user_name, connections
    puts user_name
    puts "---------------"
    puts connections
    puts "\n"
  end

end
