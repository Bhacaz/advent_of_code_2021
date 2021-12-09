# frozen_string_literal: true

class Line
  def initialize(x1, y1, x2, y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def only_horizontal_or_vertical?
    @x1 == @x2 || @y1 == @y2
  end

  def vector_of_points
    v = []
    xs = [@x1, @x2].sort
    ys = [@y1, @y2].sort
    (xs.first..xs.last).each do |x|
      (ys.first..ys.last).each do |y|
        v << [x, y]
      end
    end
    v
  end
end

class Part < BasePart
  DAY = 5
  def run
    input
    counter = Hash.new { |h, k| h[k] = 0 }
    @lines.select(&:only_horizontal_or_vertical?).each do |line|
      line.vector_of_points.each do |point|
        counter[point] += 1
      end
    end
    counter.values.count { |v| v >= 2} # => 5774
  end

  def input
    @input ||=
      begin
        raw_input = super
        @lines = []
        raw_input.each do |raw_line|
          points = raw_line.scan(/\d+/).flatten.map(&:to_i)
          @lines << Line.new(*points)
        end
      end
  end
end
