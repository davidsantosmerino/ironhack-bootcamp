require './.config/twitter-config'

class Twitter
  def initialize
    @client = TwitterConfig.config
  end

end
