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
  attr_accessor :symbol
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265E".colorize(color: color)
    @team = team
  end
end

class Bishop
  attr_accessor :symbol
  attr_reader :team

  def initialize(color, team)
    @symbol = "\u265D".colorize(color: color)
    @team = team
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