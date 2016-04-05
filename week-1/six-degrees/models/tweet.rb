class Tweet
  attr_reader :author

  def initialize author, message
    @author = author
    @message = message
  end

  def mentions
    starting_with_at = /@\w+/
    raw_mentions = @message.scan starting_with_at

    raw_mentions.map { |mention| mention.gsub(/\@/, '')  }
  end

end
