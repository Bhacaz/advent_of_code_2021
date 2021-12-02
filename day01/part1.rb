class Part < BasePart
  DAY = 1
  def run
    increase = 0
    input.each_with_index do |deep, index|
      next unless input[index - 1]

      increase += 1 if deep > input[index - 1]
    end
    increase # => 1298
  end

  def input
    @input ||= super.map(&:to_i)
  end
end
