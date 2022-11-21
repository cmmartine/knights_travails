require './board'

class Knight
  def initialize
    @board = nil
  end

  def knight_movement(start, finish, board_status)
    board_status[start[0]][start[1]].replace('|_H')
    board_status[finish[0]][finish[1]].replace('|_H')
    potential_positions = potential_moves(start)
    p potential_positions
    valid_moves = remove_invalid_moves(potential_positions)
    p valid_moves
  end

  def potential_moves(current)
    potential_spots = []
    #12 oclock spots
    potential_spots << [current[0] - 2, current[1] - 1]
    potential_spots << [current[0] - 2, current[1] + 1]
    #3 oclock spots
    potential_spots << [current[0] - 1, current[1] + 2]
    potential_spots << [current[0] + 1, current[1] + 2]
    #6 oclock spots
    potential_spots << [current[0] + 2, current[1] - 1]
    potential_spots << [current[0] + 2, current[1] + 1]
    #9 oclock spots
    potential_spots << [current[0] - 1, current[1] - 2]
    potential_spots << [current[0] + 1, current[1] - 2]
    potential_spots
  end

  def remove_invalid_moves(potential_positions)
    valid_moves = []
    potential_positions.each do |spot|
      unless spot[0] <= 0 || spot[0] > 8 || spot[1] <= 0  ||spot[1] > 8
        valid_moves << spot
      end
    end
    valid_moves
  end
end