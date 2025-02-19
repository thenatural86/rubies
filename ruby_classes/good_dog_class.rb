class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def initialize(color)
    super
    @color = color
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

# sparky = GoodDog.new
# paws = Cat.new
# puts sparky.speak
# puts paws.speak

bruno = GoodDog.new("brown")
