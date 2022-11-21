require './knight'

class Board
  attr_reader :board

  def initialize
    @board = [
      ['  ', '  1', '  2', '  3', '  4', '  5', '  6', '  7', '  8', "\n"],
      ['1 ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['2 ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['3 ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['4 ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['5 ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['6 ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['7 ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"],
      ['8 ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', '|_ ', "\n"]
    ]
  end

  def print_board(board = @board)
    puts board.join(' ')
  end

  def knight(start, finish, board = @board)
    knight = Knight.new
    updated_board = knight.knight_movement(start, finish, board)
    @board = updated_board
    self.print_board(updated_board)
  end
end

board = Board.new
board.print_board
board.knight([1, 1], [5, 6])
