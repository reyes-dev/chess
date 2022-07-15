class String
  def symbol
    " "
  end
end

class Square
  attr_accessor :space, :piece, :color
  def initialize(piece = " ", color)
    @piece = piece
    @color = color
    @space = " #{piece.symbol} ".colorize(:background => @color)
  end
end

class Pawn
  attr_accessor :symbol
  def initialize(color)
    @symbol = "\u265F".colorize(:color => color)
  end
end

class Rook
  attr_accessor :symbol
  def initialize(color)
    @symbol = "\u265C".colorize(:color => color)
  end
end

class Knight
  attr_accessor :symbol
  def initialize(color)
    @symbol = "\u265E".colorize(:color => color)
  end
end

class Bishop
  attr_accessor :symbol
  def initialize(color)
    @symbol = "\u265D".colorize(:color => color)
  end
end

class Queen
  attr_accessor :symbol
  def initialize(color)
    @symbol = "\u265B".colorize(:color => color)
  end
end

class King
  attr_accessor :symbol
  def initialize(color)
    @symbol = "\u265A".colorize(:color => color)
  end
end 