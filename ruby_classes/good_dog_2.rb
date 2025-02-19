class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n,a)
    self.name = n
    self.age = a
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

def public_disclosure
  "#{self.name} in human years is #{human_years}"
end


private
def human_years
  age  * DOG_YEARS
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age
sparky.human_years
