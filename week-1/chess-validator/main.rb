Dir["./models/*"].each {|file| require file }
require "pry"

chess_validator = ChessValidator.new
