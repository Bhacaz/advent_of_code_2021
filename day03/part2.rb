# frozen_string_literal: true

class Part < BasePart
  DAY = 3
  def run
    p @oxygen = oxygen
    p @co2 = co2
    @oxygen * @co2
    # @gamma.to_i(2) * @epsilon.to_i(2) # => 3633500
  end

  def co2
    bit = 0
    to_iterate = input

    while to_iterate.size > 1
      stats_with_zeros = []
      stats_with_ones = []

      to_iterate.each do |i|
        if i[bit].zero?
          stats_with_zeros << i
        else
          stats_with_ones << i
        end
      end

      to_iterate = if stats_with_ones.size > stats_with_zeros.size
                     stats_with_zeros
                   elsif stats_with_ones.size == stats_with_zeros.size
                     stats_with_zeros
                   else
                     stats_with_ones
                   end
      bit += 1
    end

    to_iterate.join.to_i(2)
  end

  def oxygen
    bit = 0
    to_iterate = input

    while to_iterate.size > 1
      stats_with_zeros = []
      stats_with_ones = []

      to_iterate.each do |i|
        if i[bit].zero?
          stats_with_zeros << i
        else
          stats_with_ones << i
        end
      end

      to_iterate = if stats_with_ones.size > stats_with_zeros.size
                     stats_with_ones
                   elsif stats_with_ones.size == stats_with_zeros.size
                     stats_with_ones
                   else
                     stats_with_zeros
                   end
      bit += 1
    end

    to_iterate.join.to_i(2)
  end

  def input
    @input ||= begin
                 raw_input = super
                 raw_input.map! { |line| line.chars.map(&:to_i) }
                 raw_input
               end
  end
end
