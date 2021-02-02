#!/usr/bin/ruby

# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

class PassportList
  attr_accessor :rawlist, :dirtylist, :list, :valid

  def initialize(raw_input)
    @rawlist = raw_input
    @dirtylist = raw_input.split("\n\n")
    @list = clean_up
    @valid = count_valid
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
    new_passport[:valid] = is_valid(new_passport)
    new_passport
  end

  def initialize_blank_passport
    { byr: '', iyr: '', eyr: '', hgt: '', hcl: '', ecl: '', pid: '', cid: '', valid: nil}
  end

  def is_valid(passport)
    required_fields = %i[byr iyr eyr hgt hcl ecl pid]
    if !passport.values.any?('')
      return true
    elsif required_fields.map{ |req| passport[req] == '' }.any?(true)
      return false
    else
      return true
    end
  end

  def count_valid
    @list.count { |e| e[:valid] == true }
  end

end
