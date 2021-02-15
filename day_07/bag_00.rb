#!/usr/bin/ruby
require_relative '../helpers'
require 'multiset'


class Bag
  include Enumerable
  attr_accessor :contents, :name

  def initialize(name, contents)
    @name = name
    @contents = contents
  end

  def has_inside(baglist, bag_name, searchlist)
    searched = searchlist
    searched << @name
    puts "Searching #{@name} for #{bag_name}"
    return self if bag_name == @name
    puts "Searching contents of #{@name} for #{bag_name}"
    contents.keys.each do |inside_bag|
      puts "--- searching #{baglist[inside_bag].name} for #{bag_name}..."
      found_bag = baglist[inside_bag].has_inside(baglist, bag_name, searched)
      if !found_bag.nil?
        searched << bag_name
        puts searched.to_s
        searched = []
      end
      return found_bag unless found_bag.nil?
    end
    nil
  end

  def each(&block)
    @contents.each(&block)
  end
end

class BagHandler
  include Enumerable
  attr_accessor :input, :list

  def initialize(input_array)
    @input = input_array
    @list = {}
    build_list
  end

  def build_list
    @input.each do |line|
      bag_name = line[/^(.*?)(?= bag)/, 1].tr(' ', '_').to_s
      bag_contents = line[/[1-9].*(?=\.)/]
      new_bag_contents = {}
      if !bag_contents.nil?
        bag_contents.split(", ").each do |string|
          interior_bag = string[/(?![0-9])[a-z].*(?= bag)/].tr(' ', '_').to_sym
          num_bags = string[/[0-9]*/].to_i
          new_bag_contents[interior_bag.to_sym] = num_bags
        end
      end
      @list[bag_name.to_sym] = Bag.new(bag_name, new_bag_contents)
    end
  end

  def search(target_bag)
    return_array = []
    @list.each_with_object({}) do |object|
      return_array << object[1].has_inside(@list, target_bag, [])
    end
    return_array
  end

  def each(&block)
    @list.each(&block)
  end
end
