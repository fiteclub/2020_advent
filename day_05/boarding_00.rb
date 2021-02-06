#!/usr/bin/ruby
require_relative '../helpers'

class BoardingPass
  attr_accessor :bin, :binstring, :column, :position, :row, :seat
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
  def initialize(array)
    Array.new(build_list(array))
    @comparison_array = Array.new
    build_comparison_array
  end

  def build_list(input_array)
    input_array.each do |boarding_pass_string|
      self << BoardingPass.new(boarding_pass_string)
    end
  end

  def build_comparison_array
    self.each do |boardingpass|
      @comparison_array << boardingpass.bin
    end
  end

  def max
    @comparison_array.max
  end

  def min
    @comparison_array.min
  end

  def maxseat
    max.to_s.to_i(2)
  end
end

def showmax(num_passes, maximum)
  puts "#{Rainbow(num_passes).blue.bright} boarding passes."
  puts "Highest seat: #{Rainbow(maximum).green.bright}"
end
