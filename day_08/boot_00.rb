#!/usr/bin/ruby
require_relative '../helpers'

# An item in the BootList
class BootItem
  attr_accessor :action, :value, :ran, :string

  def initialize(string)
    @string = string
    @action = string.split(' ')[0]
    @value = string.split(' ')[1].to_i
    @ran = false
  end

  def run
    @ran = true
  end
end

# List of instructions -- BootItems
class BootList < Array

  def self.call
  end

  def initialize(array)
    super
    process
  end

  def process
    each_with_index do |item, idx|
      self[idx] = BootItem.new(item.to_s)
    end
  end
end

# Traverses the BootList, interpreting the instructions
class BootParser
  attr_accessor :accumulator, :exec_order

  def initialize
    @exec_order = []
    @accumulator = 0
    @position = 0
  end

  def parse(list)
    until list[@position].executed?
      read(list[@position])
    end
    @position
  end

  def read(item)
    exec(item.action, item.value)
    item.run
    @exec_order << @position
  end

  def exec(action, value)
    case action
    when 'acc'
      acc(value)
    when 'jmp'
      jmp(value)
    when 'nop'
      nop(value)
    end
  end

  def acc(int)
    @accumulator += int
    @position += 1
  end

  def jmp(int)
    @position += int
  end

  def nop
    @position += 1
  end
end
