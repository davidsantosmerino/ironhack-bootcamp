require './models/home.rb'

homes = [
  Home.new("Nizar's place", "San Juan", 2, 42),
  Home.new("Fernando's place", "Seville", 5, 47),
  Home.new("Josh's place", "Pittsburgh", 3, 41),
  Home.new("Gonzalo's place", "Málaga", 2, 45),
  Home.new("Ariel's place", "San Juan", 4, 49)
]

homes.each do |home|
  puts home.name
  puts "Price: $#{home.price} a night"
  puts
end

cities = homes.map do |home|
  home.city
end

puts cities

total_price = homes.reduce(0.0) do |sum, home|
  sum + home.price
end

puts "The average pice per night is:"
puts total_price / homes.length

total_capacities = homes.reduce(0.0) do |sum, home|
  sum + home.capacity
end

puts "The average capacity is:"
puts total_capacities / homes.length
