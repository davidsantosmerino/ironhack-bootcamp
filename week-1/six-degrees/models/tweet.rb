class Tweet
  attr_reader :user, :mentions
  def initialize user, message
    @user = user
    @message = message
    @mentions = get_mentions
  end

  def get_mentions
    starting_with_at = /@\w+/
    raw_mentions = @message.scan starting_with_at

    raw_mentions.map { |mention| mention.gsub(/\@/, '')  }
  end

  def show
    puts "@ #{@user.name} => #{@message} cc/#{@mentions}"
  end

end
