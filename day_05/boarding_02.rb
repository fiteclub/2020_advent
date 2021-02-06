#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'boarding_00'

data = get_data("input.txt", type = "array")
b = BoardingPassList.new(data)
showempty(b.emptyseat)
