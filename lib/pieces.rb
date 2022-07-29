require_relative 'moveset'
require_relative 'en_passant'
require_relative 'pawn_promotion'
require_relative 'neighbor_tile'
require_relative 'castling'
require 'colorize'
# All piece classes have a unique generate_legals method
# that utilizes a module in a different file to
# create an array of coordinates that the instance of
# that class is allowed to move to on the board
class Pawn
  include PawnMovement
  include EnPassant
  include Promotion
  include NeighborTile

  attr_accessor :symbol, :legals, :moved, :en_passant_allowed
  attr_reader :team, :choice, :color
  # A place to store Pawn instances
  # used for En Passant functionality
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
    @@instances << self
  end

  def self.instances
    @@instances
  end
  # restrict_en_passant limits a pawn from performing an
  # en passant past a single turn
  def restrict_en_passant(turn)
    @@instances.each { |pawn| pawn.en_passant_allowed = false if pawn.team == turn }
  end

  def generate_legals(init, board)
    @team == 'white' ? white_moves(board, init) : black_moves(board, init)
  end
end

class Rook
  include Cardinal

  attr_accessor :symbol, :legals, :moved
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265C".colorize(color: color)
    @team = team
    @legals = []
    @moved = false
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
  # Array of coordinates that when added to current position
  # allow Knight to potentially move onto
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

class King < Castling
  include EightMoves

  attr_accessor :symbol, :legals, :moved, :in_check
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265A".colorize(color: color)
    @team = team
    @legals = []
    @in_check = false
    @moved = false
  end
  # Array of coordinates that when added to current position
  # allow King to potentially move onto
  def possible_moves
    [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
  end

  def generate_legals(start, board)
    eight_legals(start, board)
  end
end