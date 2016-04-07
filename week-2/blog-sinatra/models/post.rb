require_relative "post-presenter"

class Post
  attr_reader :title, :date, :text, :sponsored, :author, :category

  def initialize title, date, text, sponsored, author, category
    @title = title
    @date = date
    @text = text
    @sponsored = sponsored
    @author = author
    @category = category
  end

  def print
    post_presenter = PostPresenter.new self
    post_presenter.print
  end

end
