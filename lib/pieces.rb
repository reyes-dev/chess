require 'colorize'
require_relative 'board.rb'
require_relative 'moveset.rb'
require_relative 'en_passant.rb'
require_relative 'pawn_promotion.rb'
require_relative 'neighbor_tile.rb'

class Pawn
  include PawnMovement
  include EnPassant
  include Promotion
  include NeighborTile

  attr_accessor :symbol, :legals, :moved, :en_passant_allowed
  attr_reader :team, :choice, :color

  @@instances = []

  def initialize(color, team)
    @symbol = "\u265F".colorize(color: color)
    @color = color
    @team = team
    @legals = []
    @moved = false
    @double_stepped = false
    @en_passant_allowed = false
    @passed_over = []
    @choice = nil
    @instances << self
  end
  # Generates legal moves the pawn from the current position
  def generate_legals(init, board)
    @team == 'white' ? white_moves(board, init) : black_moves(board, init)
  end
end

class Rook
  include Cardinal

  attr_accessor :symbol, :legals
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265C".colorize(color: color)
    @team = team
    @legals = []
  end

  def generate_legals(start, board)
    cardinal_legals(start, board)
  end
end

class Knight
  include EightMoves

  attr_accessor :symbol, :legals
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265E".colorize(color: color)
    @team = team
    @legals = []
  end

  def possible_moves
    [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end

  def generate_legals(start, board)
    eight_legals(start, board)
  end
end

class Bishop
  include Diagonal

  attr_accessor :symbol, :legals
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265D".colorize(color: color)
    @team = team
    @legals = []
  end

  def generate_legals(start, board)
    diagonal_legals(start, board)
  end
end

class Queen
  include Cardinal
  include Diagonal

  attr_accessor :symbol, :legals
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265B".colorize(color: color)
    @team = team
    @legals = []
  end

  def generate_legals(start, board)
    diagonal_legals(start, board)
    cardinal_legals(start, board)
  end
end

class King
  include EightMoves

  attr_accessor :symbol, :legals
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265A".colorize(color: color)
    @team = team
    @legals = []
  end

  def possible_moves
    [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
  end

  def generate_legals(start, board)
    eight_legals(start, board)
  end
end