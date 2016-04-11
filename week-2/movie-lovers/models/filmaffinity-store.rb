require "filmaffinity"

module FilmAffinityStore

  def self.top_movies limit = 9
    result = []
    search = FilmAffinity::Top.new
    search.movies.sample(limit)
  end

end
