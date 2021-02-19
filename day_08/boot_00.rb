#!/usr/bin/ruby
require_relative '../helpers'

# An item in the BootList
class BootItem
  attr_accessor :action, :ran, :runcount, :string, :value

  def initialize(string)
    @string = string
    @action = string.split(' ')[0]
    @value = string.split(' ')[1].to_i
    @ran = false
    @runcount = 0
  end

  def run
    @runcount += 1
    @ran = true
  end
end

# List of instructions; BootItems objects
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
  attr_accessor :accumulator, :log, :position, :bootlist

  def initialize(boot_list)
    @bootlist = boot_list
    @log = []
    @accumulator = 0
    @position = 0
  end

  def parse
    until bootlist[@position].ran
      read(bootlist[@position])
    end
    @log << {pos: @position, acc: @accumulator, ran: false}
    log.last
  end

  def read(item)
    log_item = {}
    log_item[:pos] = @position
    exec(item.action, item.value)
    item.run
    log_item[:acc] = @accumulator
    log_item[:ran] = true
    @log << log_item
  end

  def exec(action, value)
    case action
    when 'acc'
      acc(value)
    when 'jmp'
      jmp(value)
    when 'nop'
      nop
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
