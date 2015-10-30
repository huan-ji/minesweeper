require_relative 'tile.rb'

class Board

  attr_accessor :board

  def initialize
    @board = populate
  end

  def populate
    empty_board = Array.new(81, :e)
    9.times { |i| empty_board[i] = :b }
    empty_board.shuffle!
    bombs_board = []
    9.times { bombs_board << empty_board.shift(9) }
    bombs_board
  end

  def num_bomb_neighbors

  end

  def find_neighbors(pos)
    i, j = pos
    neighbors = [[0,1], [0,-1], [1,0], [-1, 0], [-1,1], [1,-1], [1,1], [-1,-1]]
    has_neighbor = []
    neighbors.each do |pair|
      x, y = pair
      a = x + i
      b = y + j
      next if a < 0 || b < 0 || a > 8 || b > 8
      p [a, b]
      has_neighbor << pair #unless @board[a][b].nil?
    end

    has_neighbor

  end

  def populate_tiles
    board_with_tiles = @board.map do |row|
      row.map do |tile|
        Tile.new(@board, tile)
      end
    end
    board_with_tiles
  end



end
