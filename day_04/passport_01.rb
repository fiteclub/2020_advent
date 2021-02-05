#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'passport_00'


data = get_data('input.txt')
my_list = PassportList.new(data)
# puts "#{Rainbow(my_list.list.count).blue.bright} passports scanned."
# puts "Total valid passports: #{Rainbow(my_list.valid).green.bright}"

def doscan(passport_list)
  scan_count = passport_list.list.count
  scan_valid = passport_list.valid
  puts "#{Rainbow(scan_count).blue.bright} passports scanned."
  puts "Total valid passports: #{Rainbow(scan_valid).green.bright}"
end

doscan(my_list)
