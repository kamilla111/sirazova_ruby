class Raspberry
  attr_reader :state

  @@states = ["Отсутствует", "Цветение", "Зеленая", "Красная"]

  def initialize(index)
    @index = index
    @state = @@states.first
  end

  def self.states
    @@states
  end

  def grow!
    if @@states.index(@state) + 1 <= @@states.length
      @state = @@states[@@states.index(@state) + 1]
    end
  end

  def ripe?
    @state == @@states.last
  end
end

class RaspberryBush
  def initialize(countRaspberries)
    @raspberries = Array.new(countRaspberries){Raspberry.new}
  end

  def grow_all! 
    for raspberry in @raspberries 
      raspberry.grow!
    end
  end

  def ripe_all? 
    @raspberries.all? { |raspberry| raspberry.ripe? }
  end

  def give_away_all!
    @raspberries = []
  end
end

class Human
  attr_reader :name

  def initialize(name)
    @name = name
    @plant = nil
  end

  def work!
    @plant.grow_all!
  end

  def harvest
    if @plant.ripe_all?
      @plant.give_away_all!
      p "Урожай собран!"
    else
      p "Урожай еще не созрел."
    end
  end

  def self.knowledge_base
    p " Чтобы малина перешла на следующую стадию, необходимо поливать растение. Малина созревает, когда достигает последней стадии. Спелые ягоды можно собирать."
  end
end

if __FILE__ == $PROGRAM_NAME
  Human.knowledge_base

  bush = RaspberryBush.new(7)
  human = Human.new("Petya")
  
  human.work!

  until bush.ripe_all?
    human.work!
  end

  human.harvest
end