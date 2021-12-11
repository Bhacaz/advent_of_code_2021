# frozen_string_literal: true

class CrabSubmarine
  def initialize(horizontal, fuel)
    @horizontal = horizontal
    @fuel = fuel
  end
end

class Part < BasePart
  DAY = 7
  def run
    input
    min = @crabs.min
    max = @crabs.max
    fuel_costs = 0
    min_fuel_costs = Float::INFINITY

    (min..max).each do |position|
      @crabs.each do |crab|
        n = (crab - position).abs
        (n**2 + n) / 2
        fuel_costs += (n**2 + n) / 2
      end

      if fuel_costs < min_fuel_costs
        min_fuel_costs = fuel_costs
      end
      fuel_costs = 0
    end

    min_fuel_costs # => 323647
  end

  def input
    @input ||=
      begin
        raw_input = super
        @crabs = raw_input.first.split(',').map(&:to_i)
      end
  end
end
