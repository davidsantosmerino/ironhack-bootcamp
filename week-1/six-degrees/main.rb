Dir["./models/*"].each {|file| require file }
require "./.config/twitter-config"
require "twitter"
require "pry"

user = "daaviddd13"
twitter_client = TwitterClient.new
twitter_faker = TwitterFaker.new
six_degrees = SixDegrees.new twitter_client, user

six_degrees.user_connections
