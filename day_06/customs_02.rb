#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'customs_00'

data = get_data("input.txt")
plane = CustomsPlane.new(data)
puts "Sum of unanimous group answer counts = #{colorize(plane.allsaidyes)}"
