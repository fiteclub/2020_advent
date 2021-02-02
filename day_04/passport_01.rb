#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'passport_00'


data = get_data('input.txt')
a = PassportList.new(data)
puts "#{Rainbow(a.list.count).blue.bright} passports scanned."
puts "Total valid passports: #{Rainbow(a.valid).green.bright}"