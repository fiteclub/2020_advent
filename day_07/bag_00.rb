#!/usr/bin/ruby
require_relative '../helpers'
require 'multiset'

class Bag
  include Enumerable
  attr_accessor :contents

  def initialize
    @contents = {}
  end

  def contains(search_item)
    search_term.class != 'Symbol' ? (search_item = search_item.to_sym) : nil
    @contents[search_item] != nil
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
      bag_name = line[/^(.*?)(?= bag)/, 1].tr(' ', '_').to_sym
      bag_contents = line[/[1-9].*(?=\.)/]
      new_bag= {}
      if !bag_contents.nil?
        bag_contents.split(", ").each do |string|
          sub_bag = string[/(?![0-9])[a-z].*(?= bag)/].tr(' ', '_').to_sym
          num_bags = string[/[0-9]*/].to_i
          new_bag[sub_bag.to_sym] = num_bags
        end
      end
    @list[bag_name] = new_bag
    end
  end

  def find(search_key, *primary_search)
    @list.each do |bag|
      if bag.to_a[1].empty?
        next
      elsif bag.to_a[1].has_key?search_key
        puts bag
      else
        bag.to_a[1].keys.each do |sub_bag|
          find(sub_bag)
        end
      end
    end
  end

  def each(&block)
    @list.each(&block)
  end
end
