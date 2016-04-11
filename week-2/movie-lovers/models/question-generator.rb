require_relative "question"

class QuestionGenerator
  QUESTIONS_TEMPLATES = [
    {
      :text => "Which movie was released in %s?",
      :condition => Proc.new {|movie, year| movie.year == year},
      :param => "year"
    },
    {
      :text => "Which movie is from %s?",
      :condition => Proc.new {|movie, country| movie.country == country},
      :param => "country"
    },
    {
      :text => "Which movie was directed by %s?",
      :condition => Proc.new {|movie, director| movie.director == director},
      :param => "director"
    },
    {
      :text => "Which movie was scripted by %s?",
      :condition => Proc.new {|movie, script| movie.script == script},
      :param => "script"
    },
    {
      :text => "Which movie played in %s?",
      :condition => Proc.new {|movie, actor| movie.cast.include? actor},
      :param => "cast"
    }
  ]

  def random movies
    # template = QUESTIONS_TEMPLATES.sample
    template = [QuestionCastTemplate.new, QuestionDirectorTemplate.new].sample
    text = template.text
    condition = template.condition
    all_response = movies.sample.send(template[:param])
    param_value = @parser.parse all_response

    Question.new text % param_value, condition, param_value
  end
end

class QuestionTemplate
  def initialize response_parser: PotentialResponseParser.new
    @response_parser = response_parser
  end
end

class PotentialResponseParser
  def parse response
    response
  end
end

class PotentialResponseArrayParser
  def parse response
    response.sample
  end
end
