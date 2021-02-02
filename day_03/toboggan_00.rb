#!/usr/bin/ruby

class TobogganMap
  attr_accessor :coursemap, :path, :grid, :trees

  def initialize(coursemap, path)
    @coursemap = coursemap.to_a
    @path = path
    @grid = mapgrid
  end

  def putsmap
    puts @coursemap
  end

  def printmap
    print @coursemap
  end

  def mapgrid
    new_grid = []
    @coursemap.each do |row|
      new_grid << row.split('')
    end
    @grid = new_grid
  end

  def setpath(x, y)
    @path = [x, y]
  end

  def runcourse
    @trees = 0
    position = [0,0]
    while position[1] < @grid.length
      checktree(position[0], position[1]) ? @trees += 1 : nil
      position = [position[0] += @path[0], position[1] += @path[1]]
      position[0] > @grid[0].length - 1 ? position[0] = position[0] - @grid[0].length : nil
    end
  end

  def checktree(coord_x, coord_y)
    if self.grid[coord_y][coord_x] == "#"
      return true
    else
      return false
    end
  end

end
