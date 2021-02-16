#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'bag_00'

looking_for = 'shiny_gold'
data = get_data("input.txt", 'array')
b = BagHandler.new(data)
b.build_list
puts colorarray([b.search(looking_for).length, 'bag colors can eventually contain at least one', looking_for.to_sym, 'bag']).join(' ')
