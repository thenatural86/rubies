class Person
  def initialize(age)
    @age = age
  end

  def older?(other_person)
    age > other_person.age
  end

  protected
  attr_reader :age
end

class Student

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  protected
  attr_reader :grade
  def grade
    @grade
  end
end


malory = Person.new(64)
sterling = Person.new(42)

malory.older?(sterling)
sterling.older?(malory)


#  protected methods cannot be invoked from outside of the class.
malory.age
