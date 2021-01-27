#!/usr/bin/ruby
require 'pry'
require 'json'

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

def count_valid(password_data)
  total_valid_passwords = 0
  password_data.each do |element|
    password_letter_array = element["password"].split('')
    first_index = element["first_index"] - 1
    second_index = element["second_index"] - 1
    print "#{element["password"]} needs '#{element["character"]}' : #{element["first_index"]}=#{password_letter_array[first_index]}, #{element["second_index"]}=#{password_letter_array[second_index]}"
    if (password_letter_array[first_index] == element["character"] &&
        password_letter_array[second_index] != element["character"]) || 
       (password_letter_array[first_index] != element["character"] &&
        password_letter_array[second_index] == element["character"])
      total_valid_passwords += 1
      puts ' = VALID!'
    else
      puts ' = Invalid.'
    end
  end
  puts "---\nTotal valid passwords: #{total_valid_passwords}"
end

write_to_json(input_data, 'input.json')
# Also unnecessary, used as an exercise in reading from json
data = JSON.parse(File.read('input.json'))
count_valid(data)
