require_relative 'tile.rb'

class Board

  attr_accessor :board, :tile_board
  def initialize
    @board = populate_bomb
    @tile_board = populate_tiles
  end

  def populate_bomb
    empty_board = Array.new(81, :e)
    9.times { |i| empty_board[i] = :b }
    empty_board.shuffle!
    bombs_board = []
    9.times { bombs_board << empty_board.shift(9) }
    bombs_board
  end

  def num_bomb_neighbors(pos)
    indices = find_neighbors(pos)
    bomb_count = indices.count { |pos| @board[pos[0]][pos[1]] == :b}
    bomb_count
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
      has_neighbor << [a, b]
    end

    has_neighbor

  end

  def populate_tiles
    board_with_tiles = @board.map.with_index do |row, row_index|
      row.map.with_index do |tile, tile_index|
        tile_value = nil
        if tile == :b
          tile_value = :b
        else
          tile_value = num_bomb_neighbors([row_index, tile_index])
        end
        Tile.new(tile_value, self)
      end
    end
    board_with_tiles
  end

  def base_case?(pos)
    value = @tile_board[pos[0]][pos[1]].value
    value.is_a?(Fixnum) && value > 0
  end

  def show_board
    @tile_board.map do |row|
      row.map do |tile|
        tile.value
      end
    end
  end

  def reveal(pos)
    @tile_board[pos[0]][pos[1]].revealed = true
    return nil if base_case?(pos)
    find_neighbors(pos).each do |nei|
      x, y = nei
      nei_tile = @tile_board[x][y]
      next if nei_tile.value == :b || nei_tile.revealed
      reveal([x, y])
    end
  end

end
