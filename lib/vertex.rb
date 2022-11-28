class Vertex
  attr_accessor :name, :location, :neighbors, :weights

  def initialize(name, array)
    @name = name
    @location = array
    @neighbors = []
    @weights = []
  end
end
