require './vertex'
 
class Knight
 attr_accessor :vertices
 
 def initialize
   @vertices = []
 end
 
 def create_vertices
   i = 1
   while i <= 8
     j = 1
     while j <= 8
       @vertices << Vertex.new("#{i}, #{j}", [i, j])
       j += 1
     end
     i += 1
   end
   populate_vertex_neighbors
   #list = "List: "
   #i = 0
   #vertices.each do |v|
   #list << "[#{v.name}], "
   #i += 1
   #end
   #p list
   #p i
   find_vertex('1, 1')
 end
 
 def find_vertex(name)
   vertices.each do |v|
     p v if v.name == name
     return v if v.name == name
   end
 end
 
 def knight_movement(start, finish, board_status)
   create_vertices
   board_status
 end
 
 def populate_vertex_neighbors(vertices = @vertices)
  vertices.each do |v|
    valid_moves = potential_moves(v.location)
    indexes = []
    i = 0
    vertices.each do |vert|
      if valid_moves.include?(vert.location)
        indexes << i
      end
      i += 1
    end
    p indexes

    indexes.each do |index|
      v.neighbors[index] = true
      v.weights[index] = 1
    end
  end
 end

 def potential_moves(current)
  potential_spots = []
  return if current.nil?

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
  remove_invalid_moves(potential_spots)
end

def remove_invalid_moves(potential_positions)
  valid_moves = []
  potential_positions.each do |spot|
    unless spot[0] <= 0 || spot[0] > 8 || spot[1] <= 0 || spot[1] > 8
      valid_moves << spot
    end
  end
  valid_moves
end

end
