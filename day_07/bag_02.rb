#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'bag_00'

looking_for = 'shiny_gold'
data = get_data("input.txt", 'array')
b = BagHandler.new(data)
puts colorarray([b.capacity(looking_for),
                 'individual bags are required inside a single',
                 looking_for.to_sym,
                 'bag'])
  .join(' ')
