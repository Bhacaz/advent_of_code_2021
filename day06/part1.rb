# frozen_string_literal: true

class Lanternfish
  def initialize(timer = 8, first_cycle: true)
    @timer = timer
    @first_cycle = first_cycle
  end

  def day_passed!
    @timer -= 1
    return if @timer != -1

    reset!
    self.class.new
  end

  def reset!
    @timer = 6
  end
end

class Part < BasePart
  DAY = 6
  def run
    input
    (1..80).each do
      new_fishses = []
      @fishes.each do |fish|
        new_fish = fish.day_passed!
        new_fishses << new_fish if new_fish
      end
      @fishes.concat new_fishses
    end
    @fishes.size # => 345793

  end

  def input
    @input ||=
      begin
        raw_input = super
        @fishes = []
        raw_input.first.split(',').map(&:to_i).each do |timer|
          @fishes << Lanternfish.new(timer, first_cycle: false)
        end
      end
  end
end
