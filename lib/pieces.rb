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

  def is_enemy?(start, board, diag)
    enemy = board[start[0] + diag[0]][start[1] + diag[1]].piece.team
    ally = board[start[0]][start[1]].piece.team

    unless enemy.nil?
      enemy != ally
    end
  end

  def white_moves(start, board)
    @legal_moves << [start[0] + 1, start[1]]
    @legal_moves << [start[0] + 2, start[1]] if @moved_once == false
    @legal_moves << [start[0] + 1, start[1] - 1] if is_enemy?(start, board, [1, -1])
    @legal_moves << [start[0] + 1, start[1] + 1] if is_enemy?(start, board, [1, 1])
  end

  def black_moves(start, board)
    @legal_moves << [start[0] - 1, start[1]]
    @legal_moves << [start[0] - 2, start[1]] if @moved_once == false
    @legal_moves << [start[0] - 1, start[1] + 1] if is_enemy?(start, board, [-1, 1])
    @legal_moves << [start[0] - 1, start[1] - 1] if is_enemy?(start, board, [-1, -1])
  end

  # Generates legal moves for the pawn from the current position
  def generate_legals(start, board)
    @team == 'white' ? white_moves(start, board) : black_moves(start, board)
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
  include EightMoves

  attr_accessor :symbol, :legal_moves
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265E".colorize(color: color)
    @team = team
    @legal_moves = []
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
  include EightMoves

  attr_accessor :symbol, :legal_moves
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265A".colorize(color: color)
    @team = team
    @legal_moves = []
  end

  def possible_moves
    [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
  end

  def generate_legals(start, board)
    eight_legals(start, board)
  end
end