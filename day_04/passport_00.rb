#!/usr/bin/ruby
require_relative '../helpers'

# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

class PassportList
  attr_accessor :rawlist, :dirtylist, :cleanlist

  def initialize(raw_input)
    @rawlist = raw_input
    @dirtylist = raw_input.split("\n\n")
    @cleanlist = clean_up
  end

  def clean_up
    clean = []
    @dirtylist.each do |line|
      clean << make_passport(line)
    end
    clean
  end

  def make_passport(dirty_string)
    new_passport = initialize_blank_passport
    dirty_string.split(' ').each do |sub_item|
      new_passport[sub_item.split(':')[0].to_sym] = sub_item.split(':')[1]
    end
    new_passport
  end

  def initialize_blank_passport
    { byr: '', iyr: '', eyr: '', hgt: '', hcl: '', ecl: '', pid: '', cid: '' }
  end

  def is_valid(passport)
  
  end

end

data = get_data('input.txt')
a = PassportList.new(data)

binding.pry
puts 'end'
