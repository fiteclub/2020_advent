#!/usr/bin/ruby
require 'pry'

target_sum = 2020
file = "input.txt"
input_data = File.read("input.txt")
integer_array = input_data.split.map { |string| string.to_i }

def find_sum_pair(input_array, target)
  sum_pair = [nil, nil]
  input_array.each do |entry|
    puts "Searching #{entry_prime}"
    difference = (target.to_i - entry.to_i)
    # puts "Trying #{entry}, difference of #{difference}"
    if input_array.include?(difference) && difference > 0
      sum_pair[0] = entry
      sum_pair[1] = difference
      # puts "Match found! #{sum_pair[0]} and #{sum_pair[1]}"
      puts "Answer: #{sum_pair[0]} + #{sum_pair[1]} = #{target}"
      sum_pair
    else
      false
    end
    # p sum_pair
  end
    # if
    #   puts "Answer: #{sum_pair[0]} + #{sum_pair[1]} = #{target}"
    # sum_pair
end

def find_sum_triplet(input_array_prime, target_prime)
  sum_triplet = [nil, nil]
  input_array_prime.each do |entry_prime|
    difference_prime = target_prime.to_i - entry_prime.to_i
    pair = find_sum_pair(input_array_prime, difference_prime)
    if pair != false && input_array_prime.include?(difference_prime) && difference_prime > 0
      sum_triplet[0] = entry_prime
      sum_triplet[1] = [pair[0], pair[1]]
      puts "TRIPLET Answer: #{sum_triplet[0]} + #{sum_triplet[1][0]} + #{sum_triplet[1][1]} = #{target_prime}"
      sum_triplet
    else
      false
    end
  end
end

binding.pry



answer = find_sum_triplet(integer_array, target_sum)
puts answer[0] * answer[1] * answer[2]

puts "end"
