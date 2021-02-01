require 'rainbow'
require 'terminal-table'
require 'pry'

def colorize(item)
  case item
  when Integer then
    Rainbow(item.to_s).yellow.bright
  when String then
    Rainbow(item).green
  when FalseClass then
    Rainbow(item.to_s).red
  when TrueClass then
    Rainbow(item.to_s).green
  when NilClass then
    Rainbow("nil").white
  else
    Rainbow(item.to_s).blue
  end
end

def colorarray(array)
  array.map do |element|
    colorize(element)
  end
end

def build_table(input_array)
  Terminal::Table.new do |t|
  t.rows = input_array.map { |n| colorarray(n) }
  end
end
