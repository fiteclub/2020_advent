#!/usr/bin/ruby
require_relative '../helpers'

class CustomsGroup
  include Enumerable
  attr_accessor :passengers

  def self.call
  end

  def initialize
    @passengers = []
  end

  def totals
    totals_hash = {}
    totals_hash.default = 0
    @passengers.each do |passenger|
      passenger.split('').each do |letter|
        totals_hash[letter.to_sym] += 1
      end
    end
    totals_hash
  end

  def yes
    totals.count
  end

  def allyes
    yes = totals.select do |key, count|
      count == @passengers.count
    end
    yes.count
  end

  def each(&block)
    @passengers.each(&block)
  end
end

class CustomsPlane
  include Enumerable
  attr_accessor :groups, :plane

  def initialize(plane_data)
    @plane = plane_data
    @groups = []
    build_plane(plane_data)
    @yes_scope = 'yes'
  end

  def build_plane(input_array)
    input_array.split("\n\n").each do |group|
      shovel_group = CustomsGroup.new
      shovel_group.passengers = group.split("\n")
      @groups << shovel_group
    end
  end

  def totals
    plane_totals = {}
    plane_totals.default = 0
    @groups.each do |group|
      group.totals.each do |key, count|
        plane_totals[key.to_sym] += count
      end
    end
    plane_totals
  end

  def saidyes
    yes_count = 0
    @groups.each do |group|
      yes_count += group.send("#{@yes_scope}")
    end
    @yes_scope = 'yes'
    yes_count
  end

  def allsaidyes
    @yes_scope = 'allyes'
    saidyes
  end
end
