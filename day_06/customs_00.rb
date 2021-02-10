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
    h = {}
    h.default = 0
    @passengers.each do |passenger|
      passenger.split('').each do |letter|
        h[letter.to_sym] += 1
      end
    end
    h
  end

  def yes
    totals.count
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
  end

  def build_plane(input_array)
    input_array.split("\n\n").each do |group|
      g = CustomsGroup.new
      g.passengers = group.split("\n")
      @groups << g
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
      yes_count += group.yes
    end
    yes_count
  end

end
