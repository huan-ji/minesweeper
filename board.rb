class Board
  def initialize
    @board = populate
  end

  def populate
    empty_board = Array.new(81)
    9.times { |i| empty_board[i] = :b }
    empty_board.shuffle!
    bombs_board = []
    9.times { bombs_board << empty_board.shift(9) }
    bombs_board
  end

  def populate_tiles
    board_with_tiles = []
    @board.each_with_index do |row, row_idx|
      row.each_with_index do |tile, tile_idx|
        Tile.new(@board, tile)
      end
    end
  end

end
