class GoodDog
  attr_accessor :name, :height, :weight
  @@number_of_dogs = 0
  def initialize(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
    @@number_of_dogs += 1
  end

  def self.what_am_i
    "I'm a GoodDog class!"
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def speak
    "#{self.name} says Arf!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end

end
