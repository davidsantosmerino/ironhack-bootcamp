class TwitterFaker

  def initialize file = "input.txt"
    @tweets = []
    parse_file file
  end

  def get_tweets_by_user user_name
    @tweets.select { |tweet| tweet.author == user_name  }
  end

  private
  def parse_file input
    input = IO.readlines input
    input.each do |line|
      line_content = line.split ": "
      author = line_content[0]
      message = line_content[1]
      add_tweet author, message
    end
  end

  def add_tweet author, message
    @tweets << Tweet.new(author, message)
  end

end
