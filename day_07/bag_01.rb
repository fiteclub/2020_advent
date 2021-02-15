#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'bag_00'

# data = get_data("input.txt", type = 'array')
data = get_data("test_input.txt", type = 'array')
b = BagHandler.new(data)
b.build_list

binding.pry
puts "#{colorize('end')}"
