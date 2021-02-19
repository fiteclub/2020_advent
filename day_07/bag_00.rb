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
      unless bag_contents.nil?
        bag_contents.split(', ').each do |string|
          interior_bag = string[/(?![0-9])[a-z].*(?= bag)/].tr(' ', '_').to_sym
          num_bags = string[/[0-9]*/].to_i
          new_bag_contents[interior_bag.to_sym] = num_bags
        end
      end
      @list[bag_name.to_sym] = Bag.new(bag_name, new_bag_contents)
    end
  end

  def search(target_bag)
    target_bag = symbol_guard(target_bag)
    return_array = list.map do |object|
      inspect_bag(object[0], target_bag)
    end
    return nil if return_array.compact.length == 1 || return_array.empty?
    return_array.map { |n| n if !n.nil? && n.length > 1 }.compact
  end

  def inspect_bag(bag, target_bag, accumulated_list = [])
    accumulated_list << bag
    return accumulated_list if bag == target_bag

    list[bag].contents.keys.each do |inside_bag|
      found_bag = inspect_bag(inside_bag, target_bag, accumulated_list)
      return found_bag unless found_bag.nil?
    end
    nil
  end

  def capacity(target_bag)
    target_bag = symbol_guard(target_bag)
    sum_interior(target_bag)
  end

  def sum_bag(bag)
    return 1 if list[bag].contents.empty?

    sum_interior(bag) + 1
  end

  def sum_interior(bag)
    list[bag].contents.inject(0) do |sum, inside_bag|
      sum + (sum_bag(inside_bag.to_a[0]) * inside_bag.to_a[1])
    end
  end

  def symbol_guard(var)
    var.to_sym if var.instance_of?(String)
  end

  def each(&block)
    @list.each(&block)
  end
end
