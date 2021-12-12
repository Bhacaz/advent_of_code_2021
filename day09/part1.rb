# frozen_string_literal: true

class Map
  attr_reader :data

  def initialize(data)
    @data = data
  end

  AD_OFFSET = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1]
  ].freeze

  def adjacents(x, y)
    values = AD_OFFSET.map do |ox, oy|
      if x + ox >= 0 && y + oy >= 0
        @data[y + oy] && @data[y + oy][x + ox]
      end
    end
    values.compact!
    values
  end
end

class Part < BasePart
  DAY = 9
  def run
    @map = Map.new(input)
    low_points = []
    @map.data.each_with_index do |yv, y|
      yv.each_with_index do |xv, x|
        if @map.adjacents(x, y).all? { |a| xv < a }
          low_points << xv
        end
      end
    end
    low_points.sum { |i| i + 1 } # => 558
  end

  def input
    @input ||=
      begin
        raw_input = super
        raw_input.map { |d| d.chars.map(&:to_i) }
      end
  end
end
