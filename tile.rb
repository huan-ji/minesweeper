class Tile
  attr_accessor :revealed, :value
  def initialize(value, board)
    @value = value
    @board = board
    @revealed = false
  end
end
