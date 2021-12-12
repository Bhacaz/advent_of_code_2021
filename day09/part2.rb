# frozen_string_literal: true
require 'set'
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

  def points_adjacents(x, y)
    AD_OFFSET.map { |ox, oy| [x + ox, y + oy] }.select { |i| i.all? { |j| j >= 0 } }
  end

  def basin(x_low, y_low)
    count = 1
    current_value = @data[y_low][x_low]
    point_to_visit = points_adjacents(x_low, y_low)
    points_already_visited = Set.new([[x_low, y_low]])
    in_basin = []
    while point_to_visit.any?
      point_to_visit.dup.each do |x, y|
        points_already_visited << [x, y]
        v = (@data[y] && @data[y][x]) || 9
        if v != 9 && v >= current_value
          # p [x, y]
          # p v
          count += 1
          in_basin << [x, y]
          points_adjacents(x, y).each do |new_points|
            point_to_visit << new_points unless points_already_visited.include?(new_points)
          end
        end
        point_to_visit.delete([x, y])
        point_to_visit.uniq!
      end
    end
    count
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
          low_points << [x, y]
        end
      end
    end

    score = low_points.map do |low_point|
      @map.basin(*low_point)
    end

    score.sort.last(3).reduce(:*) # => 882942
  end

  def input
    @input ||=
      begin
        raw_input = super
        raw_input.map { |d| d.chars.map(&:to_i) }
      end
  end
end
