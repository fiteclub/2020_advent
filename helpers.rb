require 'rainbow'
require 'terminal-table'
require 'pry'

def colorize(item)
  case item
  when Integer
    Rainbow(item.to_s).yellow.bright
  when String
    Rainbow(item).green
  when FalseClass
    Rainbow(item.to_s).red
  when TrueClass
    Rainbow(item.to_s).green
  when NilClass
    Rainbow('nil').white
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

def get_data(filename, type = 'raw')
  input_data = File.read(filename)
  case type
  when 'array'
    input_data.split("\n")
  when 'raw'
    input_data
  else
    input_data
  end
end
