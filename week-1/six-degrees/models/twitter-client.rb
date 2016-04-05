require './.config/twitter-config'
require 'twitter'

class TwitterClient

  def initialize
    @client = Twitter::REST::Client.new(TwitterConfig.config)
  end

  def get_tweets_by_user user_name
    all_tweets = []
    if !is_a_protected_user? user_name
      all_tweets = get_last_tweets user_name
      all_tweets = parse_tweets  user_name, all_tweets
    end

    all_tweets
  end

  private

  def is_a_protected_user? user_name
    user = @client.user user_name
    if user.status.nil?
      true
    else
      false
    end
  end

  def collect_with_max_id collection=[], max_id=nil, &block
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def get_last_tweets user, limit = 100
    options = {count:limit, include_rts: false}
    @client.user_timeline(user, options)
  end

  def get_all_tweets user
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: false}
      options[:max_id] = max_id unless max_id.nil?
      @client.user_timeline(user, options)
    end
  end

  def parse_tweets user_name, raw_tweets
    tweets = []
    raw_tweets.each do |raw_tweet|
        tweets << Tweet.new(user_name, raw_tweet.text)
    end

    tweets
  end

end
