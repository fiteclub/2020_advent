#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'bag_00'

looking_for = 'shiny_gold'
# data = get_data("input.txt", 'array')
data = get_data("test_input.txt", 'array')
# data = get_data("test_input_2.txt", 'array')
b = BagHandler.new(data)
b.build_list
# puts colorarray([b.earch(looking_for).length, 'individual bags are required inside a single', looking_for.to_sym, 'bag']).join(' ')

binding.pry
puts colorize("end")
