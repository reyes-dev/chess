require_relative "pieces.rb"

class Team
  attr_accessor :black_rook1, :black_knight1, :black_bishop1, :black_queen, :black_king, :black_bishop2, :black_knight2, :black_rook2, :black_pawn1, :black_pawn2, :black_pawn3, :black_pawn4, :black_pawn5, :black_pawn6, :black_pawn7, :black_pawn8, :white_rook1, :white_knight1, :white_bishop1, :white_queen, :white_king, :white_bishop2, :white_knight2, :white_rook2, :white_pawn1, :white_pawn2, :white_pawn3, :white_pawn4, :white_pawn5, :white_pawn6, :white_pawn7, :white_pawn8

  def initialize
    @black_rook1 = Rook.new(:black)
    @black_knight1 = Knight.new(:black)
    @black_bishop1 = Bishop.new(:black)
    @black_queen = Queen.new(:black)
    @black_king = King.new(:black)
    @black_bishop2 = Bishop.new(:black)
    @black_knight2 = Knight.new(:black)
    @black_rook2 = Rook.new(:black)
    @black_pawn1 = Pawn.new(:black)
    @black_pawn2 = Pawn.new(:black)
    @black_pawn3 = Pawn.new(:black)
    @black_pawn4 = Pawn.new(:black)
    @black_pawn5 = Pawn.new(:black)
    @black_pawn6 = Pawn.new(:black)
    @black_pawn7 = Pawn.new(:black)
    @black_pawn8 = Pawn.new(:black)

    @white_rook1 = Rook.new(:white)
    @white_knight1 = Knight.new(:white)
    @white_bishop1 = Bishop.new(:white)
    @white_queen = Queen.new(:white)
    @white_king = King.new(:white)
    @white_bishop2 = Bishop.new(:white)
    @white_knight2 = Knight.new(:white)
    @white_rook2 = Rook.new(:white)
    @white_pawn1 = Pawn.new(:white)
    @white_pawn2 = Pawn.new(:white)
    @white_pawn3 = Pawn.new(:white)
    @white_pawn4 = Pawn.new(:white)
    @white_pawn5 = Pawn.new(:white)
    @white_pawn6 = Pawn.new(:white)
    @white_pawn7 = Pawn.new(:white)
    @white_pawn8 = Pawn.new(:white)
  end
end