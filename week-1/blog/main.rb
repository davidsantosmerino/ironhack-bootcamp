require "./models/blog-publisher.rb"
require "./models/blog.rb"
require "./models/post.rb"
require "colorize"

my_blog = Blog.new
my_blog.add_post Post.new("First title", 2016-03-28, "Lorep Ipsum")
my_blog.add_post Post.new("Second title", 2016-04-28, "Lorep Ipsum", true)
my_blog.add_post Post.new("Third title", 2016-01-28, "Lorep Ipsum")
my_blog.add_post Post.new("More title", 2016-01-28, "Lorep Ipsum")
my_blog.add_post Post.new("More title", 2016-01-28, "Lorep Ipsum")
my_blog.add_post Post.new("More title", 2016-01-28, "Lorep Ipsum")
my_blog.add_post Post.new("More title", 2016-01-28, "Lorep Ipsum")
my_publisher = BlogPublisher.new my_blog

my_publisher.publish_front_page
