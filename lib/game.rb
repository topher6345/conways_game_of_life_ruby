require 'gosu'

require_relative 'board'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"
    @board = Board.new(16)
    @on = Gosu::Image.new("lib/media/cube.png")
    @counter = 0
  end

  def update
    @board = @board.update if button_down?(Gosu::MsLeft)
  end

  def draw
    @board.data.each_with_index do |row, ri|
      row.each_with_index do |col,ci|
        if col == 1
          @on.draw(ci*40, ri*40, 0)
        else
        end
      end
    end
  end
end

GameWindow.new.show