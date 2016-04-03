require "./models/twitter-faker"
require "./models/six-degrees"
require "pry"

user = "alberta"
twitter_faker = TwitterFaker.new "input.txt"
six_degrees = SixDegrees.new twitter_faker, user

six_degrees.user_connections
