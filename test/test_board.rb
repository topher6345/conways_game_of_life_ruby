require "minitest/autorun"
require_relative '../lib/board'
class BoardTest < Minitest::Test

  def test_data
    data = @board.data
    size = 10
    board = Board.new(size)
    assert_equal size, data.size
    assert_equal size, data.first.size
  end

  def setup
    @board = Board.new(10) { 0 }
  end


  def test_get
    assert_equal 0, @board.get(0,0), @board.data
  end

  def test_set
    @board.set(0,0, 1)
    assert_equal 1, @board.get(0,0), @board.data
  end
end