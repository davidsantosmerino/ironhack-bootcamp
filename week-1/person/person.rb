class Person

  attr_reader :name
  attr_accessor :age

  def initialize name, age
    @name = name
    @age = age
  end

end

david = Person.new "David", 23
puts david.name
puts david.age
david.age += 1
puts david.age