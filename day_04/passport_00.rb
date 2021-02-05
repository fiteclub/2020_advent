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
  attr_accessor :rawlist, :dirtylist, :list, :valid, :newvalid

  def initialize(raw_input)
    @rawlist = raw_input
    @dirtylist = raw_input.split("\n\n")
    @list = clean_up
    @valid = count_valid
    @newvalid = false
  end

  def list
    @list = clean_up
  end

  def valid
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
    if @newvalid
      new_validate(passport)
    else
      old_validate(passport)
    end
  end

  def new_validate(passport)
    old_result = old_validate(passport)
    valid_ecl = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']
    if old_result == false
      return false
    elsif passport[:byr].to_i < 1920 ||
          passport[:byr].to_i > 2002
      return false
    elsif passport[:iyr].to_i < 2010 ||
      passport[:iyr].to_i > 2020
      return false
    elsif passport[:eyr].to_i < 2020 ||
      passport[:eyr].to_i > 2030
      return false
    elsif passport[:hgt].count('in').zero? && 
          passport[:hgt].count('cm').zero?
      return false
    elsif passport[:hgt].count('in').zero? &&
          passport[:hgt].count('cm').positive? &&
          (
            passport[:hgt].scan(/^[0-9]*/).first.to_i < 150 ||
            passport[:hgt].scan(/^[0-9]*/).first.to_i > 193
          )
      return false
    elsif passport[:hgt].count('in').positive? && 
          passport[:hgt].count('cm').zero? &&
          (
            passport[:hgt].scan(/^[0-9]*/).first.to_i < 59 ||
            passport[:hgt].scan(/^[0-9]*/).first.to_i > 76
          )
      return false
    elsif !(passport[:hcl].match(/^#(?:[0-9a-fA-F]{3}){1,2}$/).to_s == passport[:hcl])
      return false
    elsif !valid_ecl.include?(passport[:ecl])
      return false
    elsif passport[:pid].match(/^\d{9}$/).to_s != passport[:pid]
      return false
    else
      return true
    end
  end

  def old_validate(passport)
    all_fields = %i[byr iyr eyr hgt hcl ecl pid cid]
    required_fields = %i[byr iyr eyr hgt hcl ecl pid]
    if required_fields.map{ |req| passport[req] == '' }.any?(true)
      return false
    else
      return true
    end
  end

  def count_valid
    @list.count { |e| e[:valid] == true }
  end

  def doscan
    @valid = count_valid
    scan_count = @list.count
    scan_valid = @valid
    puts "#{Rainbow(scan_count).blue.bright} passports scanned."
    puts "Total valid passports: #{Rainbow(scan_valid).green.bright}"
  end

end
