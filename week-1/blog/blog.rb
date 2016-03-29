require "pry"
require "colorize"

class Blog

  PAGE_SIZE = 3

  def initialize
    @posts = []
    @pages = []
    @current_page = 0
  end

  def add_post post
    @posts << post
  end

  def slice_pages
    @pages = @posts.each_slice(PAGE_SIZE).to_a
  end

  def publish_front_page
    @posts.sort! { |a,b| a.date <=> b.date }
    slice_pages
    get_page
  end

  def calculate_page action
    if action == "next" && !last_page?
      @current_page += 1
    elsif action == "prev" && !first_page?
      @current_page -= 1
    end
    get_page 
  end

  def first_page?
    @current_page <= 0
  end

  def last_page?
    @current_page >= @pages.length - 1
  end

  def get_page_bar
    for i in 1..@pages.length
      if @current_page+1 == i
       print "#{i} ".red
      else
        print "#{i} "
      end
    end
  end

  def get_page
    @pages[@current_page].each do |post|
      post.print
    end
    get_page_bar
    page_to_get = gets.chomp
    calculate_page page_to_get
  end

end

class Post
  attr_reader :title, :date, :text, :sponsored

  def initialize title, date, text, sponsored = false
    @title = title
    @date = date
    @text = text
    @sponsored = sponsored
  end

  def print 
    puts @sponsored ? "******** #{@title} *******" : @title
    puts "*************"
    puts @text
    puts "-------------"
  end

end

my_blog = Blog.new
my_blog.add_post Post.new("First title", 2016-03-28, "Lorep Ipsum")
my_blog.add_post Post.new("Second title", 2016-04-28, "Lorep Ipsum", true)
my_blog.add_post Post.new("Third title", 2016-01-28, "Lorep Ipsum")
my_blog.add_post Post.new("More title", 2016-01-28, "Lorep Ipsum")
my_blog.add_post Post.new("More title", 2016-01-28, "Lorep Ipsum")
my_blog.add_post Post.new("More title", 2016-01-28, "Lorep Ipsum")
my_blog.add_post Post.new("More title", 2016-01-28, "Lorep Ipsum")

my_blog.publish_front_page