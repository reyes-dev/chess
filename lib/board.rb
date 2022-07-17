require_relative 'pieces'
require_relative 'team'

class Board < Team
  attr_accessor :board

  def initialize
    super
    @board = {
      8 => { 1 => Square.new(@black_rook1, :light_white),
             2 => Square.new(@black_knight1, :light_red),
             3 => Square.new(@black_bishop1, :light_white),
             4 => Square.new(@black_queen, :light_red),
             5 => Square.new(@black_king, :light_white),
             6 => Square.new(@black_bishop2, :light_red),
             7 => Square.new(@black_knight2, :light_white),
             8 => Square.new(@black_rook2, :light_red) },

      7 => { 1 => Square.new(@black_pawn1, :light_red),
             2 => Square.new(@black_pawn2, :light_white),
             3 => Square.new(@black_pawn3, :light_red),
             4 => Square.new(@black_pawn4, :light_white),
             5 => Square.new(@black_pawn5, :light_red),
             6 => Square.new(@black_pawn6, :light_white),
             7 => Square.new(@black_pawn7, :light_red),
             8 => Square.new(@black_pawn8, :light_white) },

      6 => { 1 => Square.new(:light_white),
             2 => Square.new(:light_red),
             3 => Square.new(:light_white),
             4 => Square.new(:light_red),
             5 => Square.new(:light_white),
             6 => Square.new(:light_red),
             7 => Square.new(:light_white),
             8 => Square.new(:light_red) },

      5 => { 1 => Square.new(:light_red),
             2 => Square.new(:light_white),
             3 => Square.new(:light_red),
             4 => Square.new(:light_white),
             5 => Square.new(:light_red),
             6 => Square.new(:light_white),
             7 => Square.new(:light_red),
             8 => Square.new(:light_white) },

      4 => { 1 => Square.new(:light_white),
             2 => Square.new(:light_red),
             3 => Square.new(:light_white),
             4 => Square.new(:light_red),
             5 => Square.new(:light_white),
             6 => Square.new(:light_red),
             7 => Square.new(:light_white),
             8 => Square.new(:light_red) },

      3 => { 1 => Square.new(:light_red),
             2 => Square.new(:light_white),
             3 => Square.new(:light_red),
             4 => Square.new(:light_white),
             5 => Square.new(:light_red),
             6 => Square.new(:light_white),
             7 => Square.new(:light_red),
             8 => Square.new(:light_white) },

      2 => { 1 => Square.new(@white_pawn1, :light_white),
             2 => Square.new(@white_pawn2, :light_red),
             3 => Square.new(@white_pawn3, :light_white),
             4 => Square.new(@white_pawn4, :light_red),
             5 => Square.new(@white_pawn5, :light_white),
             6 => Square.new(@white_pawn6, :light_red),
             7 => Square.new(@white_pawn7, :light_white),
             8 => Square.new(@white_pawn8, :light_red) },

      1 => { 1 => Square.new(@white_rook1, :light_red),
             2 => Square.new(@white_knight1, :light_white),
             3 => Square.new(@white_bishop1, :light_red),
             4 => Square.new(@white_queen, :light_white),
             5 => Square.new(@white_king, :light_red),
             6 => Square.new(@white_bishop2, :light_white),
             7 => Square.new(@white_knight2, :light_red),
             8 => Square.new(@white_rook2, :light_white) }
    }
  end

  def display_board
    i = 8
    while i >= 1
      @board[i].each { |k, v| print v.space }
      puts "\n"
      i -= 1
    end
  end

  def move_to(x, y, current)
    # old piece stored in a temporary variable
    # to be moved to the chosen square
    chosen_piece = @board[current[0]][current[1]].piece
    chosen_piece.generate_legals(current, @board)

    if chosen_piece.legal_moves.any?([x, y])
      # old space emptied
      @board[current[0]][current[1]].piece = ' '
      @board[current[0]][current[1]].space = " #{@board[current[0]][current[1]].piece} ".colorize(background: @board[current[0]][current[1]].color)
      # new space filled
      @board[x][y].piece = chosen_piece
      @board[x][y].space = " #{@board[x][y].piece.symbol} ".colorize(background: @board[x][y].color)

      chosen_piece.legal_moves.clear

      chosen_piece.moved_once = true if chosen_piece.instance_of?(Pawn)
    end
  end

  def moving
    loop do
      puts 'Enter starting position: '
      old_pos = gets.chomp.split('').map(&:to_i)
      puts 'Enter where you want to go: '
      new_pos = gets.chomp.split('').each { |x| x.to_i }.map(&:to_i)

      move_to(new_pos[0], new_pos[1], old_pos)
      display_board
    end
  end
end