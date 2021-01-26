#!/usr/bin/ruby
require 'pry'

target_sum = 2020
file = "input.txt"
integer_array = File.read("input.txt").split.map { |string| string.to_i }

def find_sum_pairs(array, target_sum)
  raise 'exception' if !target_sum.is_a? Integer || target_sum < 1
  return_array = Array.new
  sum_pair = Array.new
  array.each do |entry|
    difference = (target_sum.to_i - entry.to_i)
    if difference.positive? && array.include?(difference)
      sum_pair[0] = entry.to_i
      sum_pair[1] = difference.to_i
      puts "Match: #{sum_pair[0]} + #{sum_pair[1]} = #{target_sum}"
      return_array << sum_pair
    end
  end
  return_array.uniq!
end

binding.pry

puts "end"
