#!/usr/bin/ruby
require 'pry'

target_sum = 2020
file = "input.txt"
input_data = File.read("input.txt")
integer_array = input_data.split.map { |string| string.to_i }

def find_sum_pair(input_array, target)
  sum_pair = [nil, nil]
  input_array.each do |entry|
    difference = (target.to_i - entry.to_i)
    puts "Trying #{entry}, difference of #{difference}"
    if input_array.include?(difference)
      sum_pair[0] = entry
      sum_pair[1] = difference
      puts "Match found! #{sum_pair[0]} and #{sum_pair}[1]"
    end
    p sum_pair
  end
  sum_pair
end

binding.pry

answer = find_sum_pair(integer_array, target_sum)
puts answer[0] * answer[1]

puts "end"
