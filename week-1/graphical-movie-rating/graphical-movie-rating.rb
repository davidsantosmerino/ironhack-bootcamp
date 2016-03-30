require "imdb"
require "pry"

class GraphicalMovieRating
	def initialize filename
		@filename = filename
		@movies = []
	end
	def read_file
		titles = IO.readlines @filename
		titles.each { |title| search_imdb title }
		draw_chart
	end
	def draw_chart
		@movies.each { |movie| movie.draw_chart  }
	end
	def search_imdb title
		result_search = Imdb::Search.new title
		movie = result_search.movies.first
		details_by_id movie.id
	end
	def details_by_id movie_id
		result_search = Imdb::Movie.new movie_id
		@movies << Movie.new(result_search.title, result_search.rating)
	end
end

class Movie
	attr_reader :title, :rating
	def initialize title, rating
		@title = title
		@rating = rating
    @movie_chart = MovieChart.new self
	end
	def draw_chart
		puts @movie_chart.rating_chart
	end
end

class MovieChart
	def initialize movie
		@movie = movie
	end
	def rating_chart
		chart = []
		chart << @movie.title
		chart << "--"
		for i in 1..10
			if @movie.rating && i <= @movie.rating
				chart << "|#|"
			else
				chart << "| |"
			end
		end
		chart.reverse
	end
end

graphical_movie_rating = GraphicalMovieRating.new "movies.txt"
graphical_movie_rating.read_file
