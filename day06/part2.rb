# frozen_string_literal: true

class Lanternfish
  attr_reader :timer

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
    timer_day = Array.new(9) { 0 }
    input
    @fishes.each do |fish|
      timer_day[fish.timer + 1] += 1
    end

    (1..256).each do |day|
      number_of_fish = timer_day[day % 9]
      timer_day[day % 9] = 0
      timer_day[(day + 9) % 9] += number_of_fish
      timer_day[(day + 7) % 9] += number_of_fish
    end

    timer_day.sum # => 1572643095893
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
