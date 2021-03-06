# frozen_string_literal: true

class BingoNumber
  attr_reader :number
  attr_accessor :marked

  def initialize(number)
    @number = number
    @marked = false
  end

  def mark!
    @marked = true
  end
end

class BingoBoard
  def initialize(numbers)
    @numbers = numbers.each_with_object({}) do |n, result|
      result[n] = BingoNumber.new(n)
    end
  end

  def mark(number)
    @numbers[number]&.mark!
  end

  def winning?
    !!winning_numbers
  end

  def winning_numbers
    row_winning || column_winning
  end

  def unmarked_numbers
    numbers = []
    @numbers.each_value do |n|
      numbers << n.number unless n.marked
    end
    numbers
  end

  def row_winning
    rows.detect { |n| n.all?(&:marked) }
  end

  def column_winning
    columns.detect { |n| n.all?(&:marked) }
  end

  def rows
    @rows ||= @numbers.values.each_slice(5)
  end

  def columns
    @columns ||=
      begin
        columns = Array.new(5) { [] }
        (0..4).each do |i|
          rows.each { |r| columns[i] << r[i] }
        end
        columns
      end
  end
end

class Part < BasePart
  DAY = 4
  def run
    input
    wining_board = nil
    wining_number = @draw.detect do |i_to_mark|
      @bingo_board.any? do |board|
        board.mark(i_to_mark)
        if board.winning_numbers
          wining_board = board
          true
        end
      end
    end

    wining_board.unmarked_numbers.sum * wining_number # => 10374
  end

  def input
    @input ||=
      begin
        raw_input = super
        @draw = raw_input.shift.split(',').map(&:to_i)
        raw_input.reject!(&:empty?)

        @bingo_board = []
        raw_input.each_slice(5).each do |raw_board|
          numbers = raw_board.flat_map do |line|
            line.scan(/(\d+)/).flatten.map(&:to_i)
          end
          @bingo_board << BingoBoard.new(numbers)
        end
     end
  end
end
