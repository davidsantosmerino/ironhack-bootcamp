require "./models/post-presenter.rb"

class Post
  attr_reader :title, :date, :text, :sponsored

  def initialize title, date, text, sponsored = false
    @title = title
    @date = date
    @text = text
    @sponsored = sponsored
  end

  def print
    post_presenter = PostPresenter.new self
    post_presenter.print
  end

end
