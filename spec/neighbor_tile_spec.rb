require '../lib/neighbor_tile'
require '../lib/gameplay'

describe NeighborTile do
  let(:chessboard) { Board.new }

  describe '#enemy?' do
    it 'Returns true when the adjacent square holds an enemy' do
      chessboard.board = {
        8 => { 1 => Square.new(:light_white),
               2 => Square.new(:light_red),
               3 => Square.new(:light_white),
               4 => Square.new(:light_red),
               5 => Square.new(:light_white),
               6 => Square.new(:light_red),
               7 => Square.new(:light_white),
               8 => Square.new(:light_red) },

        7 => { 1 => Square.new(:light_red),
               2 => Square.new(:light_white),
               3 => Square.new(:light_red),
               4 => Square.new(:light_white),
               5 => Square.new(:light_red),
               6 => Square.new(:light_white),
               7 => Square.new(:light_red),
               8 => Square.new(:light_white) },

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
               5 => Square.new(Pawn.new(:black, 'black'), :light_white),
               6 => Square.new(:light_red),
               7 => Square.new(:light_white),
               8 => Square.new(:light_red) },

        3 => { 1 => Square.new(:light_red),
               2 => Square.new(:light_white),
               3 => Square.new(:light_red),
               4 => Square.new(:light_white),
               5 => Square.new(Pawn.new(:white, 'white'), :light_red),
               6 => Square.new(:light_white),
               7 => Square.new(:light_red),
               8 => Square.new(:light_white) },

        2 => { 1 => Square.new(:light_white),
               2 => Square.new(:light_red),
               3 => Square.new(:light_white),
               4 => Square.new(:light_red),
               5 => Square.new(:light_white),
               6 => Square.new(:light_red),
               7 => Square.new(:light_white),
               8 => Square.new(:light_red) },

        1 => { 1 => Square.new(:light_red),
               2 => Square.new(:light_white),
               3 => Square.new(:light_red),
               4 => Square.new(:light_white),
               5 => Square.new(:light_red),
               6 => Square.new(:light_white),
               7 => Square.new(:light_red),
               8 => Square.new(:light_white) }
      }
      chessboard.display_board
      pawn = chessboard.board[3][5].piece
      result = pawn.enemy?(chessboard.board, [3, 5], [1, 0])

      expect(result).to eq(true)
    end
  end
end
