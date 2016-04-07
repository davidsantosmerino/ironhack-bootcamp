class StringCalculator

  def add string_to_add
    string_values = string_to_add.split
    string_values.reduce(0) {|sum, string_value| sum + string_value.to_i }
  end

end
