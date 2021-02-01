#!/usr/bin/ruby
require 'pry'
require 'json'
require 'terminal-table'

input_data = File.read('input.txt')

# This is unnecessary, but used as an exercise in writing to json
def write_to_json(raw_input, create_filename)
  input_hash = raw_input.split("\n").map do |line|
    string = line.split(" ")
    {"first_index" => string[0].split("-")[0].to_i, "second_index" => string[0].split("-")[1].to_i, "character" => string[1].gsub(':', ''), "password" => string[2]}
  end
  File.open("#{create_filename}", "w") do |f| 
    f.write(JSON.pretty_generate(input_hash))
  end
end

def json_to_logic_array(password_data_hash)
  return_array = []
  password_data_hash.each do |element|
    line_array = []
    password_letter_array = element["password"].split('')
    line_array[0] = "#{element["password"]}"
    line_array[1] = "#{element["character"]}"
    line_array[2] = element["first_index"] - 1
    line_array[3] = "#{password_letter_array[line_array[2]]}"
    line_array[4] = (line_array[3] == element["character"])
    line_array[5] = element["second_index"] - 1
    line_array[6] = "#{password_letter_array[line_array[5]]}"
    line_array[7] = (line_array[6] == element["character"])
    line_array[8] = (line_array[4] || line_array[7]) && !(line_array[4] && line_array[7])
    line_array[9] = "#{validity_message(line_array[4], line_array[7])}"
    return_array << line_array
  end
  return_array
end

def validity_message(first_condition, second_condition)
  if first_condition && !second_condition
    return "VALID : First index"
  elsif !first_condition && second_condition
    return "VALID : Second index"
  elsif first_condition && second_condition
    return "INVALID : Both indexes"
  elsif !first_condition && !second_condition
    return "INVALID : None!"
  end
  "ERROR!"
end

def count_valid(password_data_array)
  total_valid_passwords = 0
  password_data_array.each do |element|
    if element[8]
      total_valid_passwords += 1
    else
    end
  end
  total_valid_passwords
end

def build_table(arrayed_array)
  table = Terminal::Table.new do |t|
    t.headings = ['Password', 'Character','First Index', '', '', 'Second Index', '', '', 'Valid?', 'Reason']
    t.rows = arrayed_array
  end
end

write_to_json(input_data, 'input.json')
# Also unnecessary, used as an exercise in reading from json
data_hash = JSON.parse(File.read('input.json'))
data_array = (json_to_logic_array(data_hash))
valid_total = count_valid(data_array)
puts build_table(data_array)
puts "---\nTotal Valid: #{valid_total} "

binding.pry
puts "end"
