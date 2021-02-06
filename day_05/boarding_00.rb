#!/usr/bin/ruby
require_relative '../helpers'

## 0-127 (128) rows, 0-7 (8) columns
## F,L == 0
## B,R == 1
## convert to binary BFFFBBFRRR == 1000110111 == 567

class BoardingPass
  attr_accessor :bin, :position, :seat, :row, :column

  def initialize(string)
    @position = string
    @binstring = parse_to_binary(string)
  end

  def parse_to_binary(position_code)
    new_integer_array = []
    position_code.split('').each do |letter|
      if
        letter == 'F' || letter == 'L'
        new_integer_array << 0
      elsif
        letter == 'B' || letter == 'R'
        new_integer_array << 1
      else
        return "error!"
      end
    end
    new_integer_array.join()
  end

  def bin
    @binstring.to_i
  end

  def row
    @binstring[0..6].to_i(2)
  end

  def column
    @binstring[7..10].to_i(2)
  end

  def seat
    @binstring.to_i(2)
  end

end

class BoardingPassList < Array
  attr_accessor :list
  def initialize(array)
    @list = Array.new
    build_list(array)
  end

  def build_list(input_array)
    input_array.each do |boarding_pass_string|
      @list << BoardingPass.new(boarding_pass_string)
    end
  end

end



data = get_data("test_input.txt", type = "array")
b = BoardingPass.new(data[0])


binding.pry
puts 'end'
