#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'passport_00'


data = get_data('input.txt')
a = PassportList.new(data)
a.newvalid = true
a.list
a.doscan
