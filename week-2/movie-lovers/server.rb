require "pry"
require "sinatra"
require_relative "models/movie-lover-quizz"
require_relative "models/filmaffinity-store"
require "sinatra/reloader"

movie_lover = MovieLoverQuizz.new FilmAffinityStore

get "/play" do
  movie_lover.generate_question
  @score = movie_lover.score
  @question = movie_lover.question.text
  @movies = movie_lover.movies

  erb :play
end

post "/validate_answer" do
  movie_id = params[:movie_id].to_i
  movie_lover.validate_answer movie_id
  redirect "/play"
end
