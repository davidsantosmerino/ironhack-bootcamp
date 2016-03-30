require "imdb"
require "pry"

class GraphicalMovieRating

	def initialize filename
		@counter = 0
		@filename = filename
		@movies = []
	end

	def start
		read_file
		draw
	end

	def read_file
		titles = IO.readlines @filename
		titles.each { |title| search_movie title }
	end

	def draw
		print "\n"
		draw_graphical_movie_rating
		print "\n"
		draw_graphical_movie_caption
	end

	def draw_graphical_movie_rating
		charts = @movies.map { |movie| movie.chart  }
		for i in 0..charts.first.size-1
			charts.each_with_index do |chart, index|
				print chart[i]
			end
			print "\n"
		end
	end

	def draw_graphical_movie_caption
		@movies.each { |movie| puts "#{movie.id}.#{movie.title}" }
	end

	def search_movie title
		result_search = Imdb::Search.new title
		first_result = result_search.movies.first
		@movies << Movie.new(@counter, first_result.title, first_result.rating)
		@counter += 1
	end

end

class Movie
	attr_reader :id, :title, :rating

	def initialize id, title, rating
		@id = id
		@title = title
		@rating = rating
    @movie_chart = MovieChart.new self
	end

	def chart
		@movie_chart.rating_chart
	end

end

class MovieChart

	def initialize movie
		@movie = movie
	end

	def rating_chart
		chart = []
		chart << "|#{@movie.id}|"
		chart << "---"
		for i in 1..10
			if @movie.rating && i <= @movie.rating
				chart << "|#|"
			elsif not @movie.rating
				chart << "|?|"
			else
				chart << "| |"
			end
		end
		chart.reverse
	end

end

graphical_movie_rating = GraphicalMovieRating.new "movies.txt"
graphical_movie_rating.start
