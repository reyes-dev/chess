require '../lib/gameplay'
require '../lib/castling'

describe Castling do
  let(:chessboard) { Board.new }
  describe '#castle' do
    context 'When conditions are successfully met to allow castling' do
      xit 'Moves the king two squares over' do
      end

      xit 'Moves the rook to the square the king stepped over' do
      end
    end
  end

  describe '#squares_empty?' do
    context 'When all squares between the rook and king are empty' do
      it 'Returns true' do
        chessboard.board = {
          8 => { 1 => Square.new(Rook.new(:black, 'black'), :light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(:light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(King.new(:black, 'black'), :light_white),
                 6 => Square.new(:light_red),
                 7 => Square.new(:light_white),
                 8 => Square.new(Rook.new(:black, 'black'), :light_red) },

          7 => { 1 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 2 => Square.new(Pawn.new(:black, 'black'), :light_white),
                 3 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(:light_red),
                 6 => Square.new(Pawn.new(:black, 'black'), :light_white),
                 7 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 8 => Square.new(Pawn.new(:black, 'black'), :light_white) },

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

          2 => { 1 => Square.new(Pawn.new(:white, 'white'), :light_white),
                 2 => Square.new(Pawn.new(:white, 'white'), :light_red),
                 3 => Square.new(Pawn.new(:white, 'white'), :light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(:light_white),
                 6 => Square.new(Pawn.new(:white, 'white'), :light_red),
                 7 => Square.new(Pawn.new(:white, 'white'), :light_white),
                 8 => Square.new(Pawn.new(:white, 'white'), :light_red) },

          1 => { 1 => Square.new(Rook.new(:white, 'white'), :light_red),
                 2 => Square.new(:light_white),
                 3 => Square.new(:light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(King.new(:white, 'white'), :light_red),
                 6 => Square.new(:light_white),
                 7 => Square.new(:light_red),
                 8 => Square.new(Rook.new(:white, 'white'), :light_white) }
        }
        board = chessboard.board
        king = board[1][5].piece
        rook = board[1][8].piece
        result = king.squares_empty?(board, [1, 5], [1, 8])
        expect(result).to eq(true)
      end
    end

    context 'When a square between rook and king is occupied' do
      it 'Returns false' do
        chessboard.board = {
          8 => { 1 => Square.new(Rook.new(:black, 'black'), :light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(:light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(King.new(:black, 'black'), :light_white),
                 6 => Square.new(:light_red),
                 7 => Square.new(:light_white),
                 8 => Square.new(Rook.new(:black, 'black'), :light_red) },

          7 => { 1 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 2 => Square.new(Pawn.new(:black, 'black'), :light_white),
                 3 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(:light_red),
                 6 => Square.new(Pawn.new(:black, 'black'), :light_white),
                 7 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 8 => Square.new(Pawn.new(:black, 'black'), :light_white) },

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

          2 => { 1 => Square.new(Pawn.new(:white, 'white'), :light_white),
                 2 => Square.new(Pawn.new(:white, 'white'), :light_red),
                 3 => Square.new(Pawn.new(:white, 'white'), :light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(:light_white),
                 6 => Square.new(Pawn.new(:white, 'white'), :light_red),
                 7 => Square.new(Pawn.new(:white, 'white'), :light_white),
                 8 => Square.new(Pawn.new(:white, 'white'), :light_red) },

          1 => { 1 => Square.new(Rook.new(:white, 'white'), :light_red),
                 2 => Square.new(:light_white),
                 3 => Square.new(:light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(King.new(:white, 'white'), :light_red),
                 6 => Square.new(:light_white),
                 7 => Square.new(Knight.new(:white, 'white'), :light_red),
                 8 => Square.new(Rook.new(:white, 'white'), :light_white) }
        }
        board = chessboard.board
        king = board[1][5].piece
        rook = board[1][8].piece
        result = king.squares_empty?(board, [1, 5], [1, 8])
        expect(result).to eq(false)
      end
    end
  end

  describe '#castlable?' do
    context 'When king is in check' do
      it 'Returns false' do
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
                 5 => Square.new(Rook.new(:black, 'black'), :light_red),
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
                 8 => Square.new(Rook.new(:white, 'white'), :light_white) }
        }
        board = chessboard.board
        king = board[1][5].piece
        rook = board[1][8].piece
        result = king.castlable?(board, king, rook, [1, 5], [1, 8], 'black')
        expect(result).to eq(false)
      end
    end

    context 'When the king is not in check and neither king, nor rook have moved yet' do
      it 'Returns true' do
        chessboard.board = {
          8 => { 1 => Square.new(Rook.new(:black, 'black'), :light_white),
                 2 => Square.new(:light_red),
                 3 => Square.new(:light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(King.new(:black, 'black'), :light_white),
                 6 => Square.new(:light_red),
                 7 => Square.new(:light_white),
                 8 => Square.new(Rook.new(:black, 'black'), :light_red) },

          7 => { 1 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 2 => Square.new(Pawn.new(:black, 'black'), :light_white),
                 3 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(:light_red),
                 6 => Square.new(Pawn.new(:black, 'black'), :light_white),
                 7 => Square.new(Pawn.new(:black, 'black'), :light_red),
                 8 => Square.new(Pawn.new(:black, 'black'), :light_white) },

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

          2 => { 1 => Square.new(Pawn.new(:white, 'white'), :light_white),
                 2 => Square.new(Pawn.new(:white, 'white'), :light_red),
                 3 => Square.new(Pawn.new(:white, 'white'), :light_white),
                 4 => Square.new(:light_red),
                 5 => Square.new(:light_white),
                 6 => Square.new(Pawn.new(:white, 'white'), :light_red),
                 7 => Square.new(Pawn.new(:white, 'white'), :light_white),
                 8 => Square.new(Pawn.new(:white, 'white'), :light_red) },

          1 => { 1 => Square.new(Rook.new(:white, 'white'), :light_red),
                 2 => Square.new(:light_white),
                 3 => Square.new(:light_red),
                 4 => Square.new(:light_white),
                 5 => Square.new(King.new(:white, 'white'), :light_red),
                 6 => Square.new(:light_white),
                 7 => Square.new(:light_red),
                 8 => Square.new(Rook.new(:white, 'white'), :light_white) }
        }
        board = chessboard.board
        king = board[1][5].piece
        rook = board[1][8].piece
        result = king.castlable?(board, king, rook, [1, 5], [1, 8], 'black')
        expect(result).to eq(true)
      end
    end

    describe '#over_attacked_sqr?' do
      context 'When king attempts move over a square attacked by an enemy piece' do
        it 'Returns true' do
          chessboard.board = {
            8 => { 1 => Square.new(Rook.new(:black, 'black'), :light_white),
                   2 => Square.new(:light_red),
                   3 => Square.new(:light_white),
                   4 => Square.new(:light_red),
                   5 => Square.new(King.new(:black, 'black'), :light_white),
                   6 => Square.new(:light_red),
                   7 => Square.new(:light_white),
                   8 => Square.new(Rook.new(:black, 'black'), :light_red) },
  
            7 => { 1 => Square.new(Pawn.new(:black, 'black'), :light_red),
                   2 => Square.new(Pawn.new(:black, 'black'), :light_white),
                   3 => Square.new(Pawn.new(:black, 'black'), :light_red),
                   4 => Square.new(:light_white),
                   5 => Square.new(:light_red),
                   6 => Square.new(Pawn.new(:black, 'black'), :light_white),
                   7 => Square.new(Pawn.new(:black, 'black'), :light_red),
                   8 => Square.new(Pawn.new(:black, 'black'), :light_white) },
  
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
                   6 => Square.new(Rook.new(:black, 'black'), :light_white),
                   7 => Square.new(:light_red),
                   8 => Square.new(:light_white) },
  
            2 => { 1 => Square.new(Pawn.new(:white, 'white'), :light_white),
                   2 => Square.new(Pawn.new(:white, 'white'), :light_red),
                   3 => Square.new(Pawn.new(:white, 'white'), :light_white),
                   4 => Square.new(:light_red),
                   5 => Square.new(:light_white),
                   6 => Square.new(:light_red),
                   7 => Square.new(Pawn.new(:white, 'white'), :light_white),
                   8 => Square.new(Pawn.new(:white, 'white'), :light_red) },
  
            1 => { 1 => Square.new(Rook.new(:white, 'white'), :light_red),
                   2 => Square.new(:light_white),
                   3 => Square.new(:light_red),
                   4 => Square.new(:light_white),
                   5 => Square.new(King.new(:white, 'white'), :light_red),
                   6 => Square.new(:light_white),
                   7 => Square.new(:light_red),
                   8 => Square.new(Rook.new(:white, 'white'), :light_white) }
          }
          board = chessboard.board
          king = board[1][5].piece
          result = king.over_attacked_sqr?(board, [1, 5], [1, 8], 'black')
          expect(result).to eq(true)
        end
      end
    end

    describe '#to_attacked_sqr?' do
      context 'When the king tries to move to a square that is attacked by an enemy piece/leaves the king in check' do
        it 'Returns false' do
          chessboard.board = {
            8 => { 1 => Square.new(Rook.new(:black, 'black'), :light_white),
                   2 => Square.new(:light_red),
                   3 => Square.new(:light_white),
                   4 => Square.new(:light_red),
                   5 => Square.new(King.new(:black, 'black'), :light_white),
                   6 => Square.new(:light_red),
                   7 => Square.new(:light_white),
                   8 => Square.new(Rook.new(:black, 'black'), :light_red) },
  
            7 => { 1 => Square.new(Pawn.new(:black, 'black'), :light_red),
                   2 => Square.new(Pawn.new(:black, 'black'), :light_white),
                   3 => Square.new(Pawn.new(:black, 'black'), :light_red),
                   4 => Square.new(:light_white),
                   5 => Square.new(:light_red),
                   6 => Square.new(Pawn.new(:black, 'black'), :light_white),
                   7 => Square.new(Pawn.new(:black, 'black'), :light_red),
                   8 => Square.new(Pawn.new(:black, 'black'), :light_white) },
  
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
                   7 => Square.new(Rook.new(:black, 'black'), :light_red),
                   8 => Square.new(:light_white) },
  
            2 => { 1 => Square.new(Pawn.new(:white, 'white'), :light_white),
                   2 => Square.new(Pawn.new(:white, 'white'), :light_red),
                   3 => Square.new(Pawn.new(:white, 'white'), :light_white),
                   4 => Square.new(:light_red),
                   5 => Square.new(:light_white),
                   6 => Square.new(:light_red),
                   7 => Square.new(:light_white),
                   8 => Square.new(Pawn.new(:white, 'white'), :light_red) },
  
            1 => { 1 => Square.new(Rook.new(:white, 'white'), :light_red),
                   2 => Square.new(:light_white),
                   3 => Square.new(:light_red),
                   4 => Square.new(:light_white),
                   5 => Square.new(King.new(:white, 'white'), :light_red),
                   6 => Square.new(:light_white),
                   7 => Square.new(:light_red),
                   8 => Square.new(Rook.new(:white, 'white'), :light_white) }
          }
          board = chessboard.board
          print "\n"
          chessboard.display_board
          king = board[1][5].piece
          result = king.to_attacked_sqr?
        end
      end
    end
  end
end
