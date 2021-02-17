#!/usr/bin/ruby
require_relative '../helpers'

# Depth First Search concepts and code from Angel Jose
# https://youtu.be/h6uxVcE-2M8

class Bag
  include Enumerable
  attr_accessor :contents, :name

  def initialize(name, contents)
    @name = name
    @contents = contents
  end

# Refactor this to reproduce the same output
# @contents.keys.map { |color| color.to_s }
  def has_inside(baglist, bag_name, accumulated_search_list = [])
    searched_bags = accumulated_search_list
    searched_bags << @name
    return searched_bags if bag_name == @name
    contents.keys.each do |inside_bag|
      found_bag = baglist[inside_bag].has_inside(baglist, bag_name, searched_bags)
      if !found_bag.nil?
        found_bag = searched_bags
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
    return nil unless @list.keys.include?(target_bag.to_sym)
    return_array = []
    @list.each do |object|
      return_array << object[1].has_inside(@list, target_bag, [])
    end
    if return_array.compact.length == 1 || return_array.empty?
      return nil
    else
      return_array = return_array.compact
      return_array.delete_at(return_array.index(return_array.find { |v| v[0] == target_bag }))
      return_array
    end
  end

  def capacity(target_bag)
    target_bag = target_bag.to_sym if target_bag.class == String
    sum_interior(target_bag)
  end

  def sum_bag(bag)
    return 1 if list[bag].contents.empty?

    sum_interior(bag) + 1
  end

  def sum_interior(bag)
    container_sum = 0
    list[bag].contents.each do |inside_name, inside_count|
      inside_bag_capacity = sum_bag(inside_name) * inside_count
      container_sum += inside_bag_capacity
    end
    container_sum
  end

  def each(&block)
    @list.each(&block)
  end
end
