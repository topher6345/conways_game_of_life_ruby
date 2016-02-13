require 'pry'
class Board
  LIVE = 1
  DEAD = 0
  attr_accessor :data
  def initialize(size, &block)
    @size = size
    @data = Array.new(@size**2, &block).each_slice(@size).to_a
  end

  def neighbor_locations_for(x,y)
    [
      [[x-1,y-1], [x,y-1], [x+1,y-1]],
      [[x-1,y  ], [x,y  ], [x+1,y  ]],
      [[x-1,y+1], [x,y+1], [x+1,y+1]],
    ]
  end

  def neighbor_values(x,y)
    neighbor_locations_for(x,y).map do |row|
      row.map do |col|
        get(*col)
      end
    end
  end

  def set_9(x,y,val=1)
    neighbor_locations_for(x,y).map do |row|
      row.map do |col|
        set(*(col+[val]))
      end
    end
  end

  def locations_of(val)
    locations = []
    @data.each_with_index do |row, ri|
      row.each_with_index do |col, ci|
        locations << [ci,ri] if col == val
      end
    end
    locations
  end

  def get(x,y)
    @data[x % @size][y% @size]
  end

  def set(x,y,val=1)
    @data[x % @size][y % @size] = val
  end

  # ONE - Any live cell with fewer than two live neighbours dies, as if caused by under-population.
  # Any live cell with two or three live neighbours lives on to the next generation.
  # Any live cell with more than three live neighbours dies, as if by over-population.
  # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

  def update
    new_board = Board.new(@size) { 0 }

    @data.each_with_index do |row,i|
      row.each_with_index do |col,j|
        live = (col == LIVE)
        value_live_neighbors = live_neighbors(i,j)

        if live
          # Any live cell with fewer than two live neighbours dies,
          # as if caused by under-population.
          if value_live_neighbors < 2 then new_board.set(i,j,DEAD)

          # Any live cell with two or three live neighbours lives on to the next generation.
          elsif (value_live_neighbors==2 || value_live_neighbors==3)
            new_board.set(i,j,LIVE)
          # Any live cell with more than three live neighbours dies, as if by over-population.
          elsif value_live_neighbors > 3 then new_board.set(i,j,DEAD)
          end
        elsif !live
          if value_live_neighbors == 3
            new_board.set(i,j,LIVE)
          else
            new_board.set(i,j,DEAD)
          end
        end
      end
    end
    @data = new_board.data
    self
  end

  def live_neighbors(x,y)
    count = 0
    neighbor_values(x,y).each_with_index do |row, ri|
      row.each_with_index do |col, ci|
        next if ci == 1 && ri == 1 # center point, dont count it
        count +=1 if col == 1
      end
    end
    count
  end

  def inspect
    str = "\n"
    @data.each do |row|
      row.each do |col|
        if col == 1
          str << " ▩ "
        else
          str << "   "
        end
      end
      str << "\n"
    end
    str
  end
end
