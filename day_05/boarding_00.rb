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
  attr_accessor :comparison_array
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

  def minseat
    min.to_s.to_i(2)
  end

  def emptyseat
    ref_array = (minseat..maxseat).to_a
    sorted_self = self.each.map{ |bp| bp.seat }.sort
    ref_array - sorted_self
  end
end

def base_ten_to_binary_string(int_array)
  int_array.map do |n|
    "%010d" % n.to_s(2).to_i
  end
end

def binary_to_boarding_code(binary_string_array)
  binary_string_array.map do |string|
    newstring = string.split('').each_with_index.map do |digit, idx|
      if
        digit == '0' && idx < 7
        "F"
      elsif
        digit == '1' && idx < 7
        "B"
      elsif
        digit == '0' && idx >= 7
        "F"
      elsif
        digit == '1' && idx >= 7
        "R"
      else
        return "error!"
      end
    end
    newstring.join()
  end
end

def int_to_boarding_code(int_array)
  binary_to_boarding_code(base_ten_to_binary_string(int_array))
end

def showmax(num_passes, maximum)
  puts "#{Rainbow(num_passes).blue.bright} boarding passes."
  puts "Highest seat: #{Rainbow(maximum).green.bright}"
end

def showempty(empty_seat_array)
  puts "#{Rainbow(empty_seat_array.count).blue.bright} empty seats."
  puts "Including: #{Rainbow(empty_seat_array).green.bright}"
end
