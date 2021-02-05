#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'passport_00'


data = get_data('input.txt')
my_list = PassportList.new(data)

my_list.doscan
