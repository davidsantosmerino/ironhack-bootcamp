class PostPresenter

  def initialize post
    @post = post
  end

  def print
    puts @post.sponsored ? "******** #{@post.title} *******" : @post.title
    puts "*************"
    puts @post.text
    puts "-------------"
  end

end
