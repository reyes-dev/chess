require 'colorize'

class String
  def symbol
    ' '
  end
end

class Square
  attr_accessor :piece, :color, :space

  def initialize(piece = ' ', color)
    @piece = piece
    @color = color
    @space = " #{piece.symbol} ".colorize(background: @color)
  end
end

class Pawn
  attr_accessor :symbol, :legal_moves, :moved_once

  def initialize(color)
    @symbol = "\u265F".colorize(color: color)
    @legal_moves = []
    @moved_once = false
  end
  # Generates legal moves for the pawn from the current position
  def generate_legals(current)
    @legal_moves << [current[0] + 1, current[1]]
    @legal_moves << [current[0] + 2, current[1]] if @moved_once == false
  end
end

class Rook
  attr_accessor :symbol

  def initialize(color)
    @symbol = "\u265C".colorize(color: color)
  end
end

class Knight
  attr_accessor :symbol

  def initialize(color)
    @symbol = "\u265E".colorize(color: color)
  end
end

class Bishop
  attr_accessor :symbol

  def initialize(color)
    @symbol = "\u265D".colorize(color: color)
  end
end

class Queen
  attr_accessor :symbol

  def initialize(color)
    @symbol = "\u265B".colorize(color: color)
  end
end

class King
  attr_accessor :symbol

  def initialize(color)
    @symbol = "\u265A".colorize(color: color)
  end
end