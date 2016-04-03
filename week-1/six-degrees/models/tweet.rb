class Tweet
  attr_reader :author, :mentions

  def initialize author, message
    @author = author
    @message = message
    @mentions = get_mentions
  end

  def get_mentions
    starting_with_at = /@\w+/
    raw_mentions = @message.scan starting_with_at

    raw_mentions.map { |mention| mention.gsub(/\@/, '')  }
  end

end
