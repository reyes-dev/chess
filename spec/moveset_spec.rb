require '../lib/gameplay'
require '../lib/moveset'

describe Cardinal do
  let(:chessboard) { Board.new }

  describe '#check_team' do
    it 'Returns the team of the given piece' do
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
               5 => Square.new(Rook.new(:white, 'white'), :light_white),
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
      rook = board[4][5].piece
      result = rook.check_team(4, 5, board)

      expect(result).to eq('white')
    end
  end

  describe '#upwards_legals' do
    it 'Adds the correct squares to a rooks @legals' do
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
               5 => Square.new(Rook.new(:white, 'white'), :light_white),
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
      rook = board[4][5].piece
      rook.upwards_legals([4, 5], board)
      result = rook.legals

      expect(result).to eq([[5, 5], [6, 5], [7, 5], [8, 5]])
    end
  end

  describe '#downwards_legals' do
    it 'Adds the correct squares to a rooks @legals' do
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
               5 => Square.new(Rook.new(:white, 'white'), :light_white),
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
      rook = board[4][5].piece
      rook.downwards_legals([4, 5], board)
      result = rook.legals

      expect(result).to eq([[3, 5], [2, 5], [1, 5]])
    end
  end

  describe '#rightwards_legals' do
    it 'Adds the correct squares to a rooks @legals' do
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
               5 => Square.new(Rook.new(:white, 'white'), :light_white),
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
      rook = board[4][5].piece
      rook.rightwards_legals([4, 5], board)
      result = rook.legals

      expect(result).to eq([[4, 6], [4, 7], [4, 8]])
    end
  end

  describe '#leftwards_legals' do
    it 'Adds the correct squares to a rooks @legals' do
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
               5 => Square.new(Rook.new(:white, 'white'), :light_white),
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
      rook = board[4][5].piece
      rook.leftwards_legals([4, 5], board)
      result = rook.legals

      expect(result).to eq([[4, 4], [4, 3], [4, 2], [4, 1]])
    end
  end
end

describe Diagonal do
  let(:chessboard) { Board.new }

  describe '#find_diagonals' do
    it 'Adds diagonal squares to bishop @legals' do
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
               5 => Square.new(Bishop.new(:white, 'white'), :light_white),
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
      bishop = board[4][5].piece
      bishop.find_diagonals([4, 5], board, [1, 1])
      result = bishop.legals
      expect(result).to eq([[5, 6], [6, 7], [7, 8]])
    end
  end

  describe '#diagonal_legals' do
    context 'When two enemy pieces are in the way and one team piece is in the way' do
      it 'Adds legal diagonal squares in four directions to bishop @legals' do
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
                 7 => Square.new(Pawn.new(:black, 'black'), :light_white),
                 8 => Square.new(:light_red) },

          5 => { 1 => Square.new(:light_red),
                 2 => Square.new(:light_white),
                 3 => Square.new(:light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(:light_red),
                 6 => Square.new(Pawn.new(:black, 'black'), :light_white),
                 7 => Square.new(:light_red),
                 8 => Square.new(:light_white) },

          4 => { 1 => Square.new(:light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(:light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(Bishop.new(:white, 'white'), :light_white),
                 6 => Square.new(:light_red),
                 7 => Square.new(:light_white),
                 8 => Square.new(:light_red) },

          3 => { 1 => Square.new(:light_red),
                 2 => Square.new(:light_white),
                 3 => Square.new(:light_red),
                 4 => Square.new(Pawn.new(:white, 'white'), :light_white),
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
        bishop = board[4][5].piece
        bishop.diagonal_legals([4, 5], board)
        result = bishop.legals
        expect(result).to eq([[5, 4], [6, 3], [7, 2], [8, 1], [5, 6], [3, 6], [2, 7], [1, 8]])
      end
    end
  end
end

describe EightMoves do
  let(:chessboard) { Board.new }
  describe '#eight_legals' do
    context 'When one enemy, one ally on adjacent tiles, Knight is in center of board' do
      it 'Adds legal moves to Knight @legals' do
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
                 6 => Square.new(Pawn.new(:white, 'white'), :light_red),
                 7 => Square.new(:light_white),
                 8 => Square.new(:light_red) },

          5 => { 1 => Square.new(:light_red),
                 2 => Square.new(:light_white),
                 3 => Square.new(:light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(:light_red),
                 6 => Square.new(:light_white),
                 7 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 8 => Square.new(:light_white) },

          4 => { 1 => Square.new(:light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(:light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(Knight.new(:white, 'white'), :light_white),
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
        knight = board[4][5].piece
        knight.eight_legals([4, 5], board)
        result = knight.legals
        expect(result).to eq([[5, 7], [5, 3], [3, 7], [3, 3], [6, 4], [2, 6], [2, 4]])
      end
    end
  end
end

describe PawnMovement do
  let(:chessboard) { Board.new }
  describe '#white_moves' do
    context 'When an enemy pawn is diagonal and forward squares are empty' do
      it 'Adds legal moves to Pawn #legals' do
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
                 5 => Square.new(:light_white),
                 6 => Square.new(:light_red),
                 7 => Square.new(:light_white),
                 8 => Square.new(:light_red) },

          3 => { 1 => Square.new(:light_red),
                 2 => Square.new(:light_white),
                 3 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 6 => Square.new(:light_white),
                 7 => Square.new(:light_red),
                 8 => Square.new(:light_white) },

          2 => { 1 => Square.new(:light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(:light_white),
                 4 => Square.new(Pawn.new(:white, 'white'), :light_red),
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
        pawn = board[2][4].piece
        pawn.white_moves(board, [2, 4])
        result = pawn.legals
        expect(result).to eq([[3, 4], [4, 4], [3, 3], [3, 5]])
      end
    end
  end
end
