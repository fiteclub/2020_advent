require_relative '../helpers'
require_relative 'customs_00'

# data = get_data("input.txt")
data = get_data("test_input.txt")
plane = CustomsPlane.new(data)

binding.pry
puts 'end'
