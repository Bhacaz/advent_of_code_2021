# frozen_string_literal: true

class LineDecoder
  attr_reader :output

  def initialize(note, output)
    @note = note.map { |o| o.chars.sort.join }
    @output = output
    @dictionary = {}
    init_decoder
  end

  def decode(segments)
    @dictionary[segments.chars.sort.join]
  end

  def init_decoder
    # 1
    @dictionary[@note.detect { |n| n.size == 2 }] = 1
    # 4
    @dictionary[@note.detect { |n| n.size == 4 }] = 4
    # 7
    @dictionary[@note.detect { |n| n.size == 3 }] = 7
    # 8
    @dictionary[@note.detect { |n| n.size == 7 }] = 8

    @note.select { |n| n.size == 5 }.each do |n|
      @dictionary[n] =
        if contains?(@dictionary.key(1), n)
          # 3
          3
        elsif (@dictionary.key(4).chars - n.chars).size == 1
          # 5
          5
        else
          # 2
          2
        end
    end

    @note.select { |n| n.size == 6 }.each do |n|
      @dictionary[n] =
        if contains?(@dictionary.key(1), n) && contains?(@dictionary.key(4), n)
          # 9
          9
        elsif !contains?(@dictionary.key(1), n)
          # 6
          6
        else
          # 0
          0
        end
    end
  end

  def contains?(source, include)
    (source.chars - include.chars).empty?
  end
end

class Part < BasePart
  DAY = 8
  def run
    input
    count = 0
    @line_decoders.each do |decoder|
      number = decoder.output
      number_s = +''
      number.each do |digit|
        number_s << decoder.decode(digit).to_s
      end
      count += number_s.to_i
    end
    count
  end

  def decode_digit(code_display)
    chars = code_display.chars
    if ('cagedb'.chars - chars).empty?
      0
    elsif ('ab'.chars - chars).empty?
      1
    elsif ('gcdfa'.chars - chars).empty?
      2
    elsif ('fbcad'.chars - chars).empty?
      3
    elsif ('eafb'.chars - chars).empty?
      4
    elsif ('cdfbe'.chars - chars).empty?
      5
    elsif ('cdfgeb'.chars - chars).empty?
      6
    elsif ('dab'.chars - chars).empty?
      7
    elsif ('acedgfb'.chars - chars).empty?
      8
    elsif ('cefabd'.chars - chars).empty?
      9
    end.to_s
  end

  def input
    @input ||=
      begin
        raw_input = super
        @line_decoders = []
        raw_input.each do |line|
          note, output = line.split(' | ')
          @line_decoders << LineDecoder.new(note.split(' '), output.split(' '))
        end
      end
  end
end
