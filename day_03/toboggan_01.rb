#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'toboggan_00'

data = get_data('input.txt', 'array')
path = [3, 1]

my_toboggan_course = TobogganMap.new(data, path)
my_toboggan_course.runcourse
puts "Using map 'input.txt'"
puts "Slope is #{my_toboggan_course.path}"
puts "Total Trees : #{my_toboggan_course.trees}"
