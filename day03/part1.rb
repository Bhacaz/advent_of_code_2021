# frozen_string_literal: true

class Part < BasePart
  DAY = 3
  def run
    number_length = input.first.size
    @gamma = []
    @epsilon = []

    Array.new(number_length).each_with_index do |_, bit|
      zeros = 0
      ones = 0
      input.each do |i|
        if i[bit].zero?
          zeros += 1
        else
          ones += 1
        end
      end
      @gamma <<
        if zeros > ones
          0
        else
          1
        end
    end

    @gamma.each do |i|
      @epsilon <<
        if i.zero?
          1
        else
          0
        end
    end

    @gamma = @gamma.join
    @epsilon = @epsilon.join

    @gamma.to_i(2) * @epsilon.to_i(2)
  end

  def input
    @input ||= begin
      raw_input = super
      raw_input.map! { |line| line.chars.map(&:to_i) }
      raw_input
    end
  end
end
