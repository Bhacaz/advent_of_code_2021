# frozen_string_literal: true

class CrabSubmarine
  def initialize(horizontal, fuel)
    @horizontal = horizontal
    @fuel = fuel
  end
end

class Part < BasePart
  DAY = 8
  def run
    input
    count = 0
    @outputs.flatten.each do |output|
      case output.size
      when 2, 3, 4, 7
        count += 1
      end
    end
    count
  end

  def input
    @input ||=
      begin
        raw_input = super
        @outputs = []
        raw_input.each do |line|
          _note, output = line.split(' | ')
          @outputs << output.split(' ')
        end
      end
  end
end
