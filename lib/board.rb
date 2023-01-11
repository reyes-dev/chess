require_relative 'pieces.rb'
require 'yaml'

class String
  # Lets a Square object set the center of @space to piece.symbol
  def symbol
    ' '
  end
  # For when square checking methods check the team of
  # the piece on a square but the square is empty
  def team
  end

  def generate_legals(init = nil, board = nil)
  end

  def legals
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

class Board
  attr_accessor :board, :dbl_step_pawn, :stepped_over, :white_king, :black_king, :white_rook1, :white_rook2, :black_rook1, :black_rook2

  def initialize
    @board = {
      8 => { 1 => Square.new(Rook.new(:black, 'black'), :default),
             2 => Square.new(Knight.new(:black, 'black'), :light_black),
             3 => Square.new(Bishop.new(:black, 'black'), :default),
             4 => Square.new(Queen.new(:black, 'black'), :light_black),
             5 => Square.new(King.new(:black, 'black'), :default),
             6 => Square.new(Bishop.new(:black, 'black'), :light_black),
             7 => Square.new(Knight.new(:black, 'black'), :default),
             8 => Square.new(Rook.new(:black, 'black'), :light_black) },

      7 => { 1 => Square.new(Pawn.new(:black, 'black'), :light_black),
             2 => Square.new(Pawn.new(:black, 'black'), :default),
             3 => Square.new(Pawn.new(:black, 'black'), :light_black),
             4 => Square.new(Pawn.new(:black, 'black'), :default),
             5 => Square.new(Pawn.new(:black, 'black'), :light_black),
             6 => Square.new(Pawn.new(:black, 'black'), :default),
             7 => Square.new(Pawn.new(:black, 'black'), :light_black),
             8 => Square.new(Pawn.new(:black, 'black'), :default) },

      6 => { 1 => Square.new(:default),
             2 => Square.new(:light_black),
             3 => Square.new(:default),
             4 => Square.new(:light_black),
             5 => Square.new(:default),
             6 => Square.new(:light_black),
             7 => Square.new(:default),
             8 => Square.new(:light_black) },

      5 => { 1 => Square.new(:light_black),
             2 => Square.new(:default),
             3 => Square.new(:light_black),
             4 => Square.new(:default),
             5 => Square.new(:light_black),
             6 => Square.new(:default),
             7 => Square.new(:light_black),
             8 => Square.new(:default) },

      4 => { 1 => Square.new(:default),
             2 => Square.new(:light_black),
             3 => Square.new(:default),
             4 => Square.new(:light_black),
             5 => Square.new(:default),
             6 => Square.new(:light_black),
             7 => Square.new(:default),
             8 => Square.new(:light_black) },

      3 => { 1 => Square.new(:light_black),
             2 => Square.new(:default),
             3 => Square.new(:light_black),
             4 => Square.new(:default),
             5 => Square.new(:light_black),
             6 => Square.new(:default),
             7 => Square.new(:light_black),
             8 => Square.new(:default) },

      2 => { 1 => Square.new(Pawn.new(:white, 'white'), :default),
             2 => Square.new(Pawn.new(:white, 'white'), :light_black),
             3 => Square.new(Pawn.new(:white, 'white'), :default),
             4 => Square.new(Pawn.new(:white, 'white'), :light_black),
             5 => Square.new(Pawn.new(:white, 'white'), :default),
             6 => Square.new(Pawn.new(:white, 'white'), :light_black),
             7 => Square.new(Pawn.new(:white, 'white'), :default),
             8 => Square.new(Pawn.new(:white, 'white'), :light_black) },

      1 => { 1 => Square.new(Rook.new(:white, 'white'), :light_black),
             2 => Square.new(Knight.new(:white, 'white'), :default),
             3 => Square.new(Bishop.new(:white, 'white'), :light_black),
             4 => Square.new(Queen.new(:white, 'white'), :default),
             5 => Square.new(King.new(:white, 'white'), :light_black),
             6 => Square.new(Bishop.new(:white, 'white'), :default),
             7 => Square.new(Knight.new(:white, 'white'), :light_black),
             8 => Square.new(Rook.new(:white, 'white'), :default) }
    }
    @dbl_step_pawn = dbl_step_pawn
    @stepped_over = stepped_over
    @white_king = @board[1][5].piece
    @white_rook1 = @board[1][1].piece
    @white_rook2 = @board[1][8].piece
    @black_king = @board[8][5].piece
    @black_rook1 = @board[8][1].piece
    @black_rook2 = @board[8][8].piece
  end

  def display_board
    i = 8
    print "    a  b  c  d  e  f  g  h\n".colorize(:red)
    while i >= 1
      print " #{i} ".colorize(:red)
      @board[i].each { |k, v| print "#{v.space}" }
      print " #{i} ".colorize(:red)
      puts "\n"
      i -= 1
    end
    print "    a  b  c  d  e  f  g  h".colorize(:red)
  end

  def to_yaml
    YAML.dump ({
      :board => @board,
      :dbl_step_pawn => @dbl_step_pawn,
      :stepped_over => @stepped_over,
      :white_king => @white_king,
      :white_rook1 => @white_rook1,
      :white_rook2 => @white_rook2,
      :black_king => @black_king,
      :black_rook1 => @black_rook1,
      :black_rook2 => @black_rook2
    })
  end
end