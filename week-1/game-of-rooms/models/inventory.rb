class Inventory

  def initialize
    @objects = []
  end

  def add_object object
    if not @objects.include? object
      @objects << object
      true
    else
      false
    end
  end

  def remove_object object
    if @objects.include? object
      @objects.delete object
      true
    else
      false
    end
  end

  def show
    puts "Inventory: "
    @objects.each { |object| puts "     - #{object}"  }.empty? and begin
      puts "        nothing"
    end
  end

end
