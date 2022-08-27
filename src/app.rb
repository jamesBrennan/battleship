require './src/ship'

class App
  attr_reader :board

  def initialize
    @board = 10.times.map do
      10.times.map { nil }
    end
    @ships = []
  end

  def print
    @board.each { |row| p row }
  end

  def place_ship(length, location, orientation)
    # find squares to operate on
    target_coords = get_target_coordinates(length, location, orientation)
    return false unless validate_coords(target_coords)

    ship = Ship.new(length)
    @ships.push(ship)

    target_coords.each do |x, y|
      @board[y][x] = ship
    end

    true
  end

  def fire(coords)
    x, y = coords
    square = @board[y][x]

    case square
    when nil
      'MISS'
    when Ship
      square.hit
      return 'WIN' if win?

      square.sunk? ? 'SUNK' : 'HIT'
    end
  end

  private

  def win?
    @ships.all? { |ship| ship.sunk? }
  end

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
