
class Position
  attr_accessor :horizontal, :depth

  def initialize
    @horizontal = 0
    @depth = 0
    @aim = 0
  end

  def move(direction, value)
    send(direction.to_sym, value)
  end

  def forward(value)
    @horizontal += value
    @depth += (@aim * value)
  end

  def down(value)
    @aim += value
  end

  def up(value)
    @aim -= value
  end
end

class Part < BasePart
  DAY = 2
  def run
    position = Position.new
    input.each { |direction, value| position.move(direction, value) }
    position.depth * position.horizontal # => 1693300
  end

  def input
    @input ||=
      begin
        raw_input = super
        raw_input.map do |line|
          direction, value = line.split(' ')
          value = value.to_i
          [direction, value]
        end
      end
  end
end
