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
      puts " Match Pair: #{sum_pair[0]} + #{sum_pair[1]} = #{target_sum}"
      return_array << sum_pair
    end
  end
  return_array.uniq!
end

def find_triplet(array, target_sum)
  return_array = Array.new
  sum_triplet = Array.new
  array.each do |entry|
    addend_pair = find_sum_pairs(array, (target_sum - entry))
    if addend_pair != nil
      sum_triplet[0] = addend_pair[0][0].to_i
      sum_triplet[1] = addend_pair[0][1].to_i
      sum_triplet[2] = entry.to_i
      puts "Triplet Match : #{sum_triplet[0]} + #{sum_triplet[1]} + #{sum_triplet[2]} = #{target_sum}"
      return_array << sum_triplet
    end
  end
  return_array.uniq!
end

answer_array = find_triplet(integer_array, target_sum)
puts "---"
puts 'Product of first triplet:'
puts (answer_array[0][0] * answer_array[0][1] * answer_array[0][2])
