#!/usr/bin/ruby
require_relative '../helpers'
require_relative 'boot_00'

data = get_data("input.txt", 'array')
bootup = BootList.new(data)
parser = BootParser.new(bootup)
parser.parse

puts colorarray(['Before looping, the',
                 :accumulator,
                 'is',
                 parser.log.last[:acc]
                 ])
  .join(' ')
