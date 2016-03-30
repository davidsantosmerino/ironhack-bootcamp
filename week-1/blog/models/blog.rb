class Blog
  attr_reader :posts

  def initialize
    @posts = []
    @current_page = 0
  end

  def add_post post
    @posts << post
  end

end
