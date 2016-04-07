class Blog
  attr_reader :posts

  def initialize
    @posts = []
    @current_page = 0
  end

  def add_post post
    @posts << post
  end

  def lastest_posts
    @posts.sort { |a,b| b.date <=> a.date }
  end

end
