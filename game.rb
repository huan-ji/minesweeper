require_relative 'board'
class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end

  def play
    until over?
      print_board
      p "new turn"
      move = get_move
      board.reveal(move)
      print_board
    end
    p "game over bro"
  end

  def over?
    board.tile_board.any? { |row| row.any? { |tile| tile.value == :b && tile.revealed } }
  end

  def get_move
    p "Make your move"
    move = gets.chomp.split(",").map(&:to_i)
    move
  end

  def print_board
    print_board = board.tile_board.map.with_index do |row, row_idx|
      row.map.with_index do |tile, tile_idx|
        if tile.revealed
          tile.value
        else
          :u
        end
      end
    end
    print_board.each { |row| p row }
  end
end
