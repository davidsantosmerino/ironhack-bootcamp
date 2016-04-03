class UserConnection
  def initialize twitter, user_name
    @twitter = twitter
    @user_name = user_name
    @connections = [[],[],[],[],[],[]]
    get_six_connections
  end

  def show_connections
    puts @user_name
    @connections.each do |connection|
      puts connection.join ", "
    end
  end

  private
  def get_six_connections
    for i in 0..5
      if i == 0
        @connections[i] = get_direct_connections @user_name
      else
        previous_level = @connections[i-1]
        previous_level.each do |previous_connection|
          new_connections = get_direct_connections previous_connection
          new_connections.each do |new_connection|
            if is_a_new_connection? new_connection
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
    user_tweets = @twitter.get_tweets_by_user user_name
    user_tweets.each do |tweet|
      candidate_connections.push(*tweet.mentions)
    end

    candidate_connections.uniq
  end

  def has_any_mention? candidate, user_name
    tweets = @twitter.get_tweets_by_user candidate

    tweets.any? do |tweet|
      tweet.mentions.include? user_name
    end
  end

  def is_a_new_connection? new_connection
    @user_name != new_connection &&
    !@connections.any? { |connection| connection.include? new_connection  }
  end

end
