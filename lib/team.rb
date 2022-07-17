require_relative "pieces.rb"

class Team
  def initialize
    @black_rook1 = Rook.new(:black, 'black')
    @black_knight1 = Knight.new(:black, 'black')
    @black_bishop1 = Bishop.new(:black, 'black')
    @black_queen = Queen.new(:black, 'black')
    @black_king = King.new(:black, 'black')
    @black_bishop2 = Bishop.new(:black, 'black')
    @black_knight2 = Knight.new(:black, 'black')
    @black_rook2 = Rook.new(:black, 'black')
    @black_pawn1 = Pawn.new(:black, 'black')
    @black_pawn2 = Pawn.new(:black, 'black')
    @black_pawn3 = Pawn.new(:black, 'black')
    @black_pawn4 = Pawn.new(:black, 'black')
    @black_pawn5 = Pawn.new(:black, 'black')
    @black_pawn6 = Pawn.new(:black, 'black')
    @black_pawn7 = Pawn.new(:black, 'black')
    @black_pawn8 = Pawn.new(:black, 'black')

    @white_rook1 = Rook.new(:white, 'white')
    @white_knight1 = Knight.new(:white, 'white')
    @white_bishop1 = Bishop.new(:white, 'white')
    @white_queen = Queen.new(:white, 'white')
    @white_king = King.new(:white, 'white')
    @white_bishop2 = Bishop.new(:white, 'white')
    @white_knight2 = Knight.new(:white, 'white')
    @white_rook2 = Rook.new(:white, 'white')
    @white_pawn1 = Pawn.new(:white, 'white')
    @white_pawn2 = Pawn.new(:white, 'white')
    @white_pawn3 = Pawn.new(:white, 'white')
    @white_pawn4 = Pawn.new(:white, 'white')
    @white_pawn5 = Pawn.new(:white, 'white')
    @white_pawn6 = Pawn.new(:white, 'white')
    @white_pawn7 = Pawn.new(:white, 'white')
    @white_pawn8 = Pawn.new(:white, 'white')
  end
end