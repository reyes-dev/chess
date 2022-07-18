require 'colorize'
require_relative 'board.rb'

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
  attr_accessor :symbol, :legal_moves
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265C".colorize(color: color)
    @team = team
    @legal_moves = []
  end
  # Returns the Team (Black or White) of the Piece 
  # at the given coordinate unless it's an empty space
  def check_team(x, y, board)
    board[x][y].piece.team if board[x][y].piece != ' '
  end
  # Four helper methods that add all the directions that
  # The Rook piece is allowed to move to legal_moves
  # Code is in place to break loop if square is filled by team
  # And to stop the loop after adding an enemy team-filled square
  def upwards_legals(start, board)
    (start[0] + 1).upto(8) do |x|
      break if board[start[0]][start[1]].piece.team == check_team(x, start[1], board)
      @legal_moves << [x, start[1]]
      break if board[x][start[1]].piece != ' '
    end
  end

  def downwards_legals(start, board)
    (start[0] - 1).downto(1) do |x|
      break if board[start[0]][start[1]].piece.team == check_team(x, start[1], board)
      @legal_moves << [x, start[1]]
      break if board[x][start[1]].piece != ' '
    end
  end

  def rightwards_legals(start, board)
    (start[1] + 1).upto(8) do |y|
      break if board[start[0]][start[1]].piece.team == check_team(start[0], y, board)
      @legal_moves << [start[0], y]
      break if board[start[0]][y].piece != ' '
    end
  end

  def leftwards_legals(start, board)
    (start[1] - 1).downto(1) do |y|
      break if board[start[0]][start[1]].piece.team == check_team(start[0], y, board)
      @legal_moves << [start[0], y]
      break if board[start[0]][y].piece != ' '
    end
  end

  def generate_legals(start, board)
    upwards_legals(start, board)
    downwards_legals(start, board)
    rightwards_legals(start, board)
    leftwards_legals(start, board)
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
  attr_accessor :symbol, :legal_moves
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265D".colorize(color: color)
    @team = team
    @legal_moves = []
  end

  def friendly?(start, chosen, board)
    unless board[start[0] + 1][start[1] - 1].nil?
      board[start[0] + 1][start[1] - 1].piece.team == board[chosen[0]][chosen[1]].piece.team
    end
  end

  def enemy?(tile, board)
    board[tile[0]][tile[1]].piece != ' '
  end

  def out_of_bounds?(start)
    !((start[0] + 1).between?(1, 8) && (start[1] - 1).between?(1, 8))
  end
  # This is supposed to add new coordinates to legal_moves
  def top_left_diag(start, board)
    loop do
      if out_of_bounds?(start) || friendly?(start, start, board)
        break
      elsif @legal_moves.empty?
        @legal_moves << (0..1).map { |i| start[i] + [1, -1][i] }
      else
        break if friendly?(@legal_moves.last, start, board) 
        break if out_of_bounds?(@legal_moves.last)
        @legal_moves << (0..1).map { |i| @legal_moves.last[i] + [1, -1][i] }
        break if enemy?(@legal_moves.last, board)
      end
    end
  end

  def top_right_diag(start, board)
  end

  def bottom_left_diag(start, board)
  end

  def bottom_right_diag(start, board)
  end

  def generate_legals(start, board)
    top_left_diag(start, board)
  end
end

class Queen
  attr_accessor :symbol
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265B".colorize(color: color)
    @team = team
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