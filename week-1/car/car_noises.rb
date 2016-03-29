class Car

  attr_reader :wheels, :noise

  def initialize (noise = "bruum")
    @wheels = 4
    @noise = noise
  end
  
end

class Motorbike

  attr_reader :wheels, :noise

  def initialize (noise = "bruumpumpum")
    @wheels = 2
    @noise = noise
  end
  
end

class WheelsCounter

  def self.total vehicles
    puts vehicles.reduce(0){|sum, vehicle| sum + vehicle.wheels}
  end

end

class NoisePrinter

  def self.sound vehicles
    vehicles.each do |vehicle|
      puts vehicle.noise
    end
  end

end

vehicles = [Car.new, Motorbike.new]
WheelsCounter.total vehicles
NoisePrinter.sound vehicles
