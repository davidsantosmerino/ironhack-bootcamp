require "sinatra"

require_relative "models/blog"
require_relative "models/post"

require "sinatra/reloader"

my_blog = Blog.new
my_blog.add_post Post.new("First title", Time.new(2016, 03, 31), "Lorep Ipsum", false, "David", "IT" )
my_blog.add_post Post.new("Second title", Time.new(2016, 03, 11), "Lorep Ipsum", true, "David", "IT")
my_blog.add_post Post.new("Third title", Time.new(2016, 03, 01), "Lorep Ipsum", false, "David", "IT")
my_blog.add_post Post.new("More title", Time.new(2016, 03, 12), "Lorep Ipsum", false, "David", "IT")
my_blog.add_post Post.new("More title", Time.new(2016, 03, 21), "Lorep Ipsum", false, "David", "IT")

get "/" do
  @posts = my_blog.lastest_posts
  erb (:index)
end

get "/post/:id" do
  post_id = params[:id].to_i
  @post = my_blog.lastest_posts[post_id]
  erb (:post)
end

get "/new_post" do
  erb (:new_post)
end

post "/create_post" do
  title = params[:title]
  text = params[:text]
  post = Post.new title, Time.now, text
  my_blog.add_post post

  redirect "/"
end
