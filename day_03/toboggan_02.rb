#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'toboggan_00'

data = get_data('input.txt', 'array')
path_list = [[1,1], [3,1], [5,1], [7,1], [1,2]]
my_toboggan_course = TobogganMap.new(data, [0,0])

def check_slopes(toboggan_course, slopes)
  total_trees = 0
  slope_results = []
  slopes.each do |path|
    toboggan_course.path = path
    toboggan_course.runcourse
    slope_results << toboggan_course.trees
    puts "Using map 'input.txt'"
    puts "Slope is #{toboggan_course.path}"
    puts "Total Trees : #{toboggan_course.trees}"
    puts "---"
    total_trees += toboggan_course.trees
  end
  puts "Total Trees for all Slopes : #{total_trees}"
  slope_results.each_with_index { |result, idx| puts "#{slopes[idx]} : #{result}"}
  slope_results.inject(:*)
  puts "Product of Tree Totals #{slope_results.inject(:*)}"
end

check_slopes(my_toboggan_course, path_list)
