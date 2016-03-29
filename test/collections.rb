cities = ["miami", "barcelona", "madrid"]
capitalized_cities = cities.map {|city| city.capitalize}

puts capitalized_cities

numbers = [2, 8, 6, 4]
sum = numbers.reduce{|sum,x| sum + x}

puts sum
