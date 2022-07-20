require 'colorize'
require_relative 'board.rb'
require_relative 'moveset.rb'

class Pawn
  attr_accessor :symbol, :legal_moves, :moved_once, :en_passant_allowed
  attr_reader :team, :choice, :color

  def initialize(color, team)
    @symbol = "\u265F".colorize(color: color)
    @color = color
    @team = team
    @legal_moves = []
    @moved_once = false
    @double_stepped = false
    @en_passant_allowed = false
    @passed_over = []
    @choice = nil
  end
  # Checks if a different square, which is relative to the starting square,
  # Is nil (out of bounds) or an empty string, unless either are true it must hold a piece
  # Compares pieces on both squares
  # Returns true when teams aren't the same
  def is_enemy?(start, board, diag)
    square = board[start[0] + diag[0]][start[1] + diag[1]]
    unless square.nil? || square.piece == ' '
      enemy = square.piece.team
      ally = board[start[0]][start[1]].piece.team

      enemy != ally
    end
  end

  def white_moves(start, board)
    @legal_moves << [start[0] + 1, start[1]] unless is_enemy?(start, board, [1, 0])
    @legal_moves << [start[0] + 2, start[1]] unless @moved_once == true || is_enemy?(start, board, [2, 0])
    @legal_moves << [start[0] + 1, start[1] - 1] if is_enemy?(start, board, [1, -1])
    @legal_moves << [start[0] + 1, start[1] + 1] if is_enemy?(start, board, [1, 1])
  end

  def black_moves(start, board)
    @legal_moves << [start[0] - 1, start[1]] unless is_enemy?(start, board, [-1, 0])
    @legal_moves << [start[0] - 2, start[1]] unless @moved_once == true || is_enemy?(start, board, [-2, 0])
    @legal_moves << [start[0] - 1, start[1] + 1] if is_enemy?(start, board, [-1, 1])
    @legal_moves << [start[0] - 1, start[1] - 1] if is_enemy?(start, board, [-1, -1])
  end

  def adjacent
    [[0, 1], [0, -1]]
  end

  def double_step?(start, finish, pawn)
    if pawn.team == 'white'
      [start[0] + 2, start[1]] == [finish[0], finish[1]]
    elsif pawn.team == 'black'
      [start[0] - 2, start[1]] == [finish[0], finish[1]]
    end
  end

  def sq_stepped_over(start, finish, pawn)
    if pawn.team == 'white'
      [start[0] + 1, start[1]]
    elsif pawn.team == 'black'
      [start[0] - 1, start[1]]
    end
  end

  def en_passantable(old, fin, pawn, board, gb)
    adjacent.each do |tile|
      if is_enemy?(fin, board, tile) && double_step?(old, fin, pawn)
        board[fin[0] + tile[0]][fin[1] + tile[1]].piece.en_passant_allowed = true
        gb.dbl_step_pawn = board[fin[0]][fin[1]]
        gb.stepped_over = sq_stepped_over(old, fin, pawn)
      end
    end
  end

  def en_passant(fin, board, gb, pawn)
    if pawn.en_passant_allowed && fin == gb.stepped_over
      pawn.legal_moves << gb.stepped_over
      gb.dbl_step_pawn.piece = ' '
      gb.dbl_step_pawn.space = " #{gb.dbl_step_pawn.piece.symbol} ".colorize(background: gb.dbl_step_pawn.color)
      pawn.en_passant_allowed = false
    end
  end

  def choose_promotion(choice, pos, board)
    pawn = board[pos[0]][pos[1]].piece

    case choice
    when "queen"
      board[pos[0]][pos[1]].piece = Queen.new(pawn.color, pawn.team)
    when "rook"
      board[pos[0]][pos[1]].piece = Rook.new(pawn.color, pawn.team)
    when "knight"
      board[pos[0]][pos[1]].piece = Knight.new(pawn.color, pawn.team)
    when "bishop"
      board[pos[0]][pos[1]].piece = Bishop.new(pawn.color, pawn.team)
    end 
  end
  
  def promote?(pawn, pos, board)
    if pawn.team == 'white' && pos[0] == 8
      loop do
        puts "Promote to Queen, Rook, Knight or Bishop?"
        @choice = gets.chomp
        break if @choice.match?(/queen|rook|knight|bishop/)
      end
      choose_promotion(@choice, pos, board)
    elsif pawn.team == 'black' && pos[0] == 1
      loop do
        puts "Promote to Queen, Rook, Knight or Bishop?"
        @choice = gets.chomp
        break if @choice.match?(/queen|rook|knight|bishop/)
      end
      choose_promotion(@choice) 
    end
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