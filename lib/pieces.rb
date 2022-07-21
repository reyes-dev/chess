require 'colorize'
require_relative 'board.rb'
require_relative 'moveset.rb'
require_relative 'en_passant.rb'
require_relative 'pawn_promotion.rb'

class Pawn
  include PawnMovement
  include EnPassant
  include Promotion

  attr_accessor :symbol, :legals, :moved, :en_passant_allowed
  attr_reader :team, :choice, :color

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
  end
  # Checks if the combined arrays actually represent 
  # an existent coordinate on an 8x8 board
  def in_bounds?(init, adj)
    ((init[0] + adj[0]).between?(1, 8) && (init[1] + adj[1]).between?(1, 8))
  end
  # Returns the square object that's inside the @board
  def adj_square(board, init, adj)
    board[init[0] + adj[0]][init[1] + adj[1]] if in_bounds?(init, adj)
  end

  def no_piece?(square)
    square.nil? || square.piece == ' '
  end

  def same_team?(enemy, ally)
    enemy != ally
  end

  def enemy?(board, init, adj)
    sqr = adj_square(board, init, adj)
    same_team?(sqr.piece.team, board[init[0]][init[1]].piece.team) unless no_piece?(sqr)
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