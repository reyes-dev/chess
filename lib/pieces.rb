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
  include KnightMovement

  attr_accessor :symbol, :legal_moves
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265E".colorize(color: color)
    @team = team
    @legal_moves = []
  end

  def generate_legals(start, board)
    knight_legals(start, board)
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