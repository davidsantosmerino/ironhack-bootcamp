class Car
  
  def initialize noise
    @noise = noise
  end
  
  def make_noise
    puts @noise
  end

end

class RacingCar < Car

  def initialize
    @noise = "BROOOM"
  end

end

my_car = Car.new "bruuuum"
my_car.make_noise

my_racing_car = RacingCar.new
my_racing_car.make_noise