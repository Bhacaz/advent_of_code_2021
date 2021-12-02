class Part < BasePart
  DAY = 1
  def run
    increase = 0
    input.each_with_index do |deep, index|
      current_window = window(index)
      next if index.zero?
      next if current_window.any?(&:nil?)

      increase += 1 if current_window.sum > window(index - 1).sum
    end
    increase # => 1248
  end

  def window(index)
    input.values_at(*(index..(index + 2)).to_a)
  end

  def input
    @input ||= super.map(&:to_i)
  end
end
