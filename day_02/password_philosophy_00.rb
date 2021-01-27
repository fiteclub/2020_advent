#!/usr/bin/ruby
require 'pry'
require 'json'

input_data = File.read('input.txt')

# This is unnecessary, but used as an exercise in writing to json
def write_to_json(raw_input, create_filename)
  input_hash = raw_input.split("\n").map do |line|
    string = line.split(" ")
    {"required" => string[0], "character" => string[1].gsub(':', ''), "password" => string[2]}
  end
  File.open("#{create_filename}", "w") do |f| 
    f.write(JSON.pretty_generate(input_hash))
  end
end

def count_valid(password_data)
  total_valid_passwords = 0
  password_data.each do |element|
    character_count = element["password"].count(element["character"])
    character_minimum = element["required"].split("-")[0].to_i
    character_maximum = element["required"].split("-")[1].to_i
    print "#{element["password"]} contains #{character_count} '#{element["character"]}'s: min=#{character_minimum}, max=#{character_maximum}"
    if character_count >= character_minimum && character_count <= character_maximum
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
