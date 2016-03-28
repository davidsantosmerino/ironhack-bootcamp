class Car
  attr_reader :cities
  
  def initialize
    @cities = []
  end

  def visit city
    @cities << city
  end

end

my_car = Car.new
my_car.visit "Barcelona"
my_car.visit "New York"
puts my_car.cities