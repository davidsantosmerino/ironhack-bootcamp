class Car
  
  def initialize (noise: "Brommmm", engine: Engine.new)
    @noise = noise
    @engine = engine
  end

  def make_noise
    @engine.make_noise
    puts @noise
  end

end 

class Engine

  def initialize (noise = "Prrr")
    @noise = noise
  end

  def make_noise
    puts @noise
  end

end

my_car = Car.new()
my_racing_car = Car.new(noise: "BRRRRRRUUUUUUM", engine: Engine.new("Prpappapa"))
my_car.make_noise
my_racing_car.make_noise