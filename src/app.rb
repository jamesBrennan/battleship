class App
  attr_reader :board

  def initialize
    @board = 10.times.map do
      10.times.map { nil }
    end
  end

  def print
    @board.each { |row| p row }
  end

  def place_ship(length, location, orientation)
    # find squares to operate on
    target_coords = get_target_coordinates(length, location, orientation)
    return false unless validate_coords(target_coords)

    target_coords.each do |x, y|
      @board[y][x] = true
    end

    true
  end

  private

  def validate_coords(coords)
    #validate range
    coords.each do |x, y|
      if x > 9 or x < 0 or y > 9 or y < 0
        return false
      end
      # if square is occupied return false
      return false if @board[y][x]
    end

    true
  end

  # return an array of coordinates
  def get_target_coordinates(length, location, orientation)
    x, y = location

    case orientation
    when 'VERTICAL'
      (0...length).map { |n| [x, y+n] }
    when 'HORIZONTAL'
      (0...length).map { |n| [x+n, y] }
    end
  end
end
