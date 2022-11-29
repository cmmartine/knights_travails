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
  end

  def find_vertex(name)
    vertices.each do |v|
      p v if v.name == name
      return v if v.name == name
    end
  end

  def knight_movement(start, finish, board_status)
    create_vertices
    finished_path = dijkstra_algo(start, finish)

    path_string = 'Shortest Path:'
    i = 1
    finished_path.each do |vert|
      if i != finished_path.length
        path_string << " #{vert} -> "
      else
        path_string << " #{vert}"
      end
      board_status[vert[0]][vert[1]].replace("|#{i}H")
      i += 1
    end
    p path_string
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
      #p indexes

      indexes.each do |index|
        v.neighbors[index] = true
        v.weights[index] = 1
      end
    end
  end

  def potential_moves(current)
    potential_spots = []
    return if current.nil?

    # 12 oclock spots
    potential_spots << [current[0] - 2, current[1] - 1]
    potential_spots << [current[0] - 2, current[1] + 1]
    # 3 oclock spots
    potential_spots << [current[0] - 1, current[1] + 2]
    potential_spots << [current[0] + 1, current[1] + 2]
    # 6 oclock spots
    potential_spots << [current[0] + 2, current[1] - 1]
    potential_spots << [current[0] + 2, current[1] + 1]
    # 9 oclock spots
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

  def dijkstra_algo(start, finish)
    start_index = vertices.index { |v| v.location == start }
    finish_index = vertices.index { |v| v.location == finish }

    distances = Array.new(vertices.length, 1.0 / 0.0)
    distances[start_index] = 0
    tight = []
    prev = []

    vertices.length.times do
      # find unvisited vertex with min distance and mark it visited
      min = 1.0 / 0.0
      current = 0
      distances.each_with_index do |distance, i|
        if distance < min && !tight[i]
          min = distance
          current = i
        end
      end
      tight[current] = true

      # check path from vertex to each neighbor for weights (all are one in this case)
      vertices[current].neighbors.each_with_index do |bool, i|
        if bool && (distances[current] + vertices[current].weights[i] < distances[i])
          distances[i] = distances[current] + vertices[current].weights[i]
          prev[i] = current
        end
      end
    end

    if distances[finish_index] == 1.0/0.0
      'No path exists.'
    else
      # p show_route(prev, start_index, finish_index)
      route_array(prev, start_index, finish_index)
    end
  end

  def show_route(prev, start, finish)
    str = vertices[finish].name
    pointer = finish
    until pointer == start
      str = vertices[prev[pointer]].name + " -> " + str
      pointer = prev[pointer]
    end
    str
  end

  def route_array(prev, start, finish)
    array = []
    array << vertices[finish].location
    pointer = finish
    until pointer == start
      array << vertices[prev[pointer]].location
      pointer = prev[pointer]
    end
    array.reverse
  end
end
