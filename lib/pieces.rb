require 'colorize'
require_relative 'board.rb'
require_relative 'moveset.rb'

class Pawn
  include PawnMovement
  
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

  def tiles
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

  def store_dbl(gb, board, fin)
    gb.dbl_step_pawn = board[fin[0]][fin[1]]
  end

  def store_step(gb, pawn_team, init)
    gb.stepped_over = sq_stepped_over(pawn_team, init)
  end

  def setup_passant(gb, board, pawn, init, fin, adj)
    allow_passant(board, fin, adj)
    store_dbl(gb, board, fin)
    store_step(gb, pawn, init)
  end

  def passantable?(board, pawn, init, fin, adj)
    enemy?(board, fin, adj) && double_step?(pawn, init, fin)
  end

  def en_passantable(gb, board, pawn, init, fin)
    tiles.each { |t| setup_passant(gb, board, pawn.team, init, fin, t) if passantable?(board, pawn.team, init, fin, t) }
  end

  def do_ep?(gb, fin)
    @en_passant_allowed && fin == gb.stepped_over
  end

  def perform_ep(gb)
    @legals << gb.stepped_over
    gb.dbl_step_pawn.piece = ' '
    gb.dbl_step_pawn.space = " #{gb.dbl_step_pawn.piece.symbol} ".colorize(background: gb.dbl_step_pawn.color)
    @en_passant_allowed = false
  end

  def en_passant(gb, fin)
    perform_ep(gb) if do_ep?(gb, fin)
  end

  def update_space(pawn)
    pawn.space = " #{pawn.piece.symbol} ".colorize(background: pawn.color)
  end

  def promote(choice, color)
    case choice
    when "queen"
      pawn.piece = Queen.new(color.to_sym, color)
    when "rook"
      pawn.piece = Rook.new(color.to_sym, color)
    when "knight"
      pawn.piece = Knight.new(color.to_sym, color)
    when "bishop"
      pawn.piece = Bishop.new(color.to_sym, color)
    end
  end

  def choose_promotion
    loop do
      puts "Promote to Queen, Rook, Knight or Bishop?"
      @choice = gets.chomp
      break if @choice.match?(/queen|rook|knight|bishop/)
    end
  end

  def ready_to_promote?(color, pos)
    (color == 'white' && pos[0] == 8) || (color == 'black' && pos[0] == 1)
  end

  def promotion(board, pos, color)
    pawn = board[pos[0]][pos[1]]
    choose_promotion
    promote(@choice, color)
    update_space(pawn)
  end

  def promote?(board, pos, color)
    promotion(board, pos, color) if ready_to_promote?(color, pos)
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