require './board'

class Knight
  def initialize
    @board = nil
  end

  def knight_movement(start, finish, board_status)
    board_status[start[0]][start[1]].replace('|_H')
    board_status[finish[0]][finish[1]].replace('|_H')
    board_status
  end
end