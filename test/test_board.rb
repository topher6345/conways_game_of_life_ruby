require 'minitest/autorun'
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
    @size = 10
    @board = Board.new(@size) { 0 }
  end

  def test_get
    assert_equal 0, @board.get(0, 0), @board.data
  end

  def test_set
    @board.set(0, 0, 1)
    assert_equal 1, @board.get(0, 0), @board.data
  end

  def test_get_wraps
    @board.set(@size - 1, @size - 1, 1)
    assert_equal 0, @board.get(0, 0), @board.data
  end

  def test_neighbor_locations
    assert_equal [
      [[2, 2], [3, 2], [4, 2]],
      [[2, 3], [3, 3], [4, 3]],
      [[2, 4], [3, 4], [4, 4]]],
                 @board.neighbor_locations_for(3, 3)
  end

  def test_neighbor_values
    assert_equal [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]],
                 @board.neighbor_values(3, 3)

    @board.set(3, 3, 1)

    assert_equal [
      [0, 0, 0],
      [0, 1, 0],
      [0, 0, 0]],
                 @board.neighbor_values(3, 3)

    assert_equal [
      [0, 0, 0],
      [0, 0, 1],
      [0, 0, 0]],
                 @board.neighbor_values(2, 3)
  end

  def test_set_9
    @board.set_9(3, 3, 1)
    assert_equal [
      [1, 1, 1],
      [1, 1, 1],
      [1, 1, 1]],
                 @board.neighbor_values(3, 3)
  end

  def test_locations_of
    @board.set_9(3, 3, 1)
    assert_equal @board.neighbor_locations_for(3, 3).flatten(1),
                 @board.locations_of(1)
  end

  def test_live_neighbors
    @board.set_9(3, 3, 1)
    assert_equal 8, @board.live_neighbors(3, 3)
  end
end
