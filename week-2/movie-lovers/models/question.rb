class Question
  attr_reader :text, :condition, :param
  def initialize text, condition, param
    @text = text
    @condition = condition
    @param = param
  end

end
