require 'gosu'

require_relative 'board'

class GameWindow < Gosu::Window
  def initialize
    super 1000, 800
    self.caption = 'The Game of Life'
    @board = Board.new(32) { [0, 1].sample }
    @on = Gosu::Image.new('lib/media/cube.png')
    @counter = 0
  end

  def update
    @board.update if (@counter % 30).zero?
    @counter += 1
  end

  def draw
    @board.data.each_with_index do |row, ri|
      row.each_with_index do |col, ci|
        @on.draw(ci * 40, ri * 40, 0) if col == 1
      end
    end
  end
end
