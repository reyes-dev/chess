require '../lib/gameplay'
require '../lib/checkmate'

describe Check do
  let(:chessboard) { Board.new }
  let(:check) { Check.new }
  describe '#check?' do
    context 'When white king is in check' do
      it 'Returns true' do
        chessboard.board = {
          8 => { 1 => Square.new(:light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(:light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(King.new(:black, 'black'), :light_white),
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
                 5 => Square.new(Rook.new(:white, 'white'), :light_red),
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
                 5 => Square.new(King.new(:white, 'white'), :light_red),
                 6 => Square.new(:light_white),
                 7 => Square.new(:light_red),
                 8 => Square.new(:light_white) }
        }
        board = chessboard.board
        #  chessboard.display_board
        king = board[8][5].piece
        result = check.check?(board, king, 'white')
        expect(result).to eq(true)
      end
    end

    context 'When white king is not in check' do
      it 'Returns false' do
        chessboard.board = {
          8 => { 1 => Square.new(:light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(:light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(:light_white),
                 6 => Square.new(King.new(:black, 'black'), :light_red),
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
                 5 => Square.new(Rook.new(:white, 'white'), :light_red),
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
                 5 => Square.new(King.new(:white, 'white'), :light_red),
                 6 => Square.new(:light_white),
                 7 => Square.new(:light_red),
                 8 => Square.new(:light_white) }
        }
        board = chessboard.board
        #  print "\n"
        #  chessboard.display_board
        king = board[8][6].piece
        result = check.check?(board, king, 'white')
        expect(result).to eq(false)
      end
    end
  end

  describe '#mate?' do
    context 'When black king cannot move out of check/is mated' do
      it 'Returns true' do
        chessboard.board = {
          8 => { 1 => Square.new(:light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(:light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(Rook.new(:white, 'white'), :light_white),
                 6 => Square.new(:light_red),
                 7 => Square.new(:light_white),
                 8 => Square.new(King.new(:black, 'black'), :light_red) },

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
                 8 => Square.new(King.new(:white, 'white'), :light_red) },

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
        board = chessboard.board
        #print "\n"
        #chessboard.display_board
        king = board[8][8].piece
        result = check.mate?(board, king, 'black', 'white')
        expect(result).to eq(true)
      end
    end
  end

  describe '#filter_legals' do
    context 'When black king is in check' do
      it 'Restricts certain legal moves that would otherwise be available' do
        chessboard.board = {
          8 => { 1 => Square.new(:light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(King.new(:black, 'black'), :light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(Bishop.new(:black, 'black'), :light_white),
                 6 => Square.new(:light_red),
                 7 => Square.new(:light_white),
                 8 => Square.new(:light_red) },

          7 => { 1 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 2 => Square.new(Pawn.new(:black, 'black'), :light_white),
                 3 => Square.new(Pawn.new(:black, 'black'), :light_red),
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

          5 => { 1 => Square.new(Rook.new(:black, 'black'), :light_red),
                 2 => Square.new(:light_white),
                 3 => Square.new(:light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(:light_red),
                 6 => Square.new(Bishop.new(:white, 'white'), :light_white),
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
                 7 => Square.new(Pawn.new(:white, 'white'), :light_red),
                 8 => Square.new(:light_white) },

          2 => { 1 => Square.new(:light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(:light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(:light_white),
                 6 => Square.new(Pawn.new(:white, 'white'), :light_red),
                 7 => Square.new(:light_white),
                 8 => Square.new(Pawn.new(:white, 'white'), :light_red) },

          1 => { 1 => Square.new(:light_red),
                 2 => Square.new(:light_white),
                 3 => Square.new(:light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(:light_red),
                 6 => Square.new(Rook.new(:white, 'white'), :light_white),
                 7 => Square.new(King.new(:white, 'white'), :light_red),
                 8 => Square.new(:light_white) }
        }
        board = chessboard.board
        print "\n"
        chessboard.display_board
        king = board[8][3].piece
        bishop = board[8][5].piece
        bishop.generate_legals([8, 5], board)
        check.filter_legals(board, king, bishop, [8, 5], 'white')
        result = bishop.legals
        expect(result).to eq([[7, 4]])
      end
    end
  end
end
