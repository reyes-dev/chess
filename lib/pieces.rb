require 'colorize'
require_relative 'board.rb'
require_relative 'moveset.rb'

class Pawn
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

  def white_legal_forwards(board, init)
    @legals << [init[0] + 1, init[1]] unless enemy?(board, init, [1, 0])
    @legals << [init[0] + 2, init[1]] unless @moved == true || enemy?(board, init, [2, 0])
  end

  def black_legal_forwards(board, init)
    @legals << [init[0] - 1, init[1]] unless enemy?(board, init, [-1, 0])
    @legals << [init[0] - 2, init[1]] unless @moved == true || enemy?(board, init, [-2,0])
  end

  def w_m
    [[1, -1], [1, 1]]
  end

  def white_legal_diag(board, init)
    w_m.each { |m| @legals << [init[0] + m[0], init[1] + m[1]] if enemy?(board, init, m) }
  end

  def b_m
    [[-1, 1], [-1, -1]]
  end

  def black_legal_diag(board, init)
    b_m.each { |m| @legals << [init[0] + m[0], init[1] + m[1]] if enemy?(board, init, m) }
  end

  def white_moves(board, init)
    white_legal_forwards(board, init)
    white_legal_diag(board, init)
  end

  def black_moves(board, init)
    black_legal_forwards(board, init)
    white_legal_diag(board, init)
  end

  def adj_tiles
    [[0, -1], [0, 1]]
  end

  def double_step?(pawn, init, fin)
    pawn == 'white' ? [init[0] + 2, init[1]] == [fin[0], fin[1]] : [init[0] - 2, init[1]] == [fin[0], fin[1]]
  end

  def sq_stepped_over(pawn, init)
    pawn == 'white' ? [init[0] + 1, init[1]] : [init[0] - 1, init[1]]
  end

  def allow_passant(board, fin, adj)
    board[fin[0] + adj[0]][fin[1] + adj[1]].piece.en_passant_allowed = true
  end

  def en_passantable(gb, board, pawn, init, fin)
    adj_tiles.each do |tile|
      if enemy?(board, fin, tile) && double_step?(pawn.team, init, fin)
        allow_passant(board, fin, tile)
        gb.dbl_step_pawn = board[fin[0]][fin[1]]
        gb.stepped_over = sq_stepped_over(pawn.team, init)
      end
    end
  end

  def en_passant(fin, board, gb, pawn)
    if pawn.en_passant_allowed && fin == gb.stepped_over
      pawn.legals << gb.stepped_over
      gb.dbl_step_pawn.piece = ' '
      gb.dbl_step_pawn.space = " #{gb.dbl_step_pawn.piece.symbol} ".colorize(background: gb.dbl_step_pawn.color)
      pawn.en_passant_allowed = false
    end
  end

  def choose_promotion(choice, pos, board, color)
    tile_color = board[pos[0]][pos[1]].color

    case choice
    when "queen"
      board[pos[0]][pos[1]].piece = Queen.new(color.to_sym, color)
      board[pos[0]][pos[1]].space = " #{board[pos[0]][pos[1]].piece.symbol} ".colorize(background: tile_color)
    when "rook"
      board[pos[0]][pos[1]].piece = Rook.new(color.to_sym, color)
      board[pos[0]][pos[1]].space = " #{board[pos[0]][pos[1]].piece.symbol} ".colorize(background: tile_color)
    when "knight"
      board[pos[0]][pos[1]].piece = Knight.new(color.to_sym, color)
      board[pos[0]][pos[1]].space = " #{board[pos[0]][pos[1]].piece.symbol} ".colorize(background: tile_color)
    when "bishop"
      board[pos[0]][pos[1]].piece = Bishop.new(color.to_sym, color)
      board[pos[0]][pos[1]].space = " #{board[pos[0]][pos[1]].piece.symbol} ".colorize(background: tile_color)
    end
  end

  def promote?(pawn, pos, board, color)
    if color == 'white' && pos[0] == 8
      loop do
        puts "Promote to Queen, Rook, Knight or Bishop?"
        @choice = gets.chomp
        break if @choice.match?(/queen|rook|knight|bishop/)
      end
      choose_promotion(@choice, pos, board, color)
    elsif color == 'black' && pos[0] == 1
      loop do
        puts "Promote to Queen, Rook, Knight or Bishop?"
        @choice = gets.chomp
        break if @choice.match?(/queen|rook|knight|bishop/)
      end
      choose_promotion(@choice, pos, board, color) 
    end
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