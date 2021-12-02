require_relative 'input_fetcher'

class BasePart
  DAY = 0

  def self.run
    new.run
  end

  def run
    raise NotImplementedError
  end

  def input
    @input ||= InputFetcher.day(self.class::DAY).split("\n")
  end
end
