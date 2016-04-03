class UserConnection
  def initialize user_name, tweets
    @user_name = user_name
    @tweets = tweets
    @connections = [[],[],[],[],[],[]]
    get_all_connections
  end

  def get_all_connections
    for i in 0..5
      if i == 0
        @connections[i] = get_direct_connections @user_name
      else
        previous_level = @connections[i-1]
        previous_level.each do |previous_connection|
          new_connections = get_direct_connections previous_connection
          new_connections.each do |new_connection|
            if @user_name != new_connection && !@connections.any? { |connection| connection.include? new_connection  }
              @connections[i]  << new_connection
            end
          end
        end
      end
      @connections[i].sort!
    end
  end

  def get_direct_connections user_name
    connections = []
    candidate_connections = search_candidate_connections user_name
    candidate_connections.each do |candidate|
      if has_any_mention? candidate, user_name
        connections << candidate
      end
    end

    connections
  end

  def search_candidate_connections user_name
    candidate_connections = []
    user_tweets = get_tweets_by_user user_name
    user_tweets.each do |tweet|
      tweet.mentions.each do |mention|
        candidate_connections << mention
      end
    end

    candidate_connections.uniq
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

  def show_connections
    puts @user_name
    puts "---------------"
    @connections.each do |connection|
      puts connection.join ", "
    end
  end

end
