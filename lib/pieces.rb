require 'colorize'
require_relative 'board.rb'
require_relative 'moveset.rb'

class Pawn
  attr_accessor :symbol, :legal_moves, :moved_once
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265F".colorize(color: color)
    @team = team
    @legal_moves = []
    @moved_once = false
  end
  # Generates legal moves for the pawn from the current position
  def generate_legals(current, board)
    @legal_moves << [current[0] + 1, current[1]]
    @legal_moves << [current[0] + 2, current[1]] if @moved_once == false
  end
end

class Rook
  include Cardinal

  attr_accessor :symbol, :legal_moves
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265C".colorize(color: color)
    @team = team
    @legal_moves = []
  end

  def generate_legals(start, board)
    cardinal_legals(start, board)
  end
end

class Knight
  attr_accessor :symbol, :legal_moves
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265E".colorize(color: color)
    @team = team
    @legal_moves = []
  end
  # Imitates the L-shape Knight's can move in
  def possible_moves
    [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end
  # Compares chosen piece to piece on a landing spot
  # Returning true when both squares aren't the same team
  def check_team(start, fin, board)
    board[fin[0]][fin[1]].piece.team != board[start[0]][start[1]].piece.team
  end
  # Gives all the moves Knight is allowed to make
  # From it's current position on the board
  def generate_legals(start, board)
    # Using chosen piece's coordinate, combine with each possible move
    0.upto(7) { |n| @legal_moves << (0..1).map { |i| start[i] + possible_moves[n][i] } }
    # Filter that result by keeping arrays where both elements are between 1 and 8
    @legal_moves.select! { |sqr| sqr[0].between?(1, 8) && sqr[1].between?(1, 8) }
    # Further filter out squares with friendly pieces
    @legal_moves.select! { |sqr| check_team(start, sqr, board) }
  end
end

class Bishop
  include Diagonal

  attr_accessor :symbol, :legal_moves
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265D".colorize(color: color)
    @team = team
    @legal_moves = []
  end

  def generate_legals(start, board)
    diagonal_legals(start, board)
  end
end

class Queen
  include Cardinal
  include Diagonal

  attr_accessor :symbol, :legal_moves
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265B".colorize(color: color)
    @team = team
    @legal_moves = []
  end

  def generate_legals(start, board)
    diagonal_legals(start, board)
    cardinal_legals(start, board)
  end
end

class King
  attr_accessor :symbol
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265A".colorize(color: color)
    @team = team
  end
end