require_relative "question-generator"

class MovieLoverQuizz
  attr_reader :score, :movies, :question

  def initialize movie_store
    @score = 0
    @movie_store = movie_store
    @question_generator = QuestionGenerator.new
  end

  def generate_movies
    @movies = @movie_store.top_movies
  end

  def generate_question
    generate_movies
    @question = @question_generator.random @movies
  end

  def validate_answer movie_id
    if check_answer movie_id
      @score += 1
    end
  end

  def check_answer movie_id
    @question.condition.call @movies[movie_id], @question.param
  end

end
