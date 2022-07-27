require_relative 'pieces.rb'
require_relative 'checkmate.rb'

class Castling < Check
  def squares_empty?(board, king_pos, rook_pos)
    is_empty = []

    if king_pos[1] > rook_pos[1]
      (king_pos[1] - 1).downto(rook_pos[1] + 1) do |i|
        is_empty << (board[king_pos[0]][i].piece == ' ')
      end
    elsif king_pos[1] < rook_pos[1]
      (king_pos[1] + 1).upto(rook_pos[1] - 1) do |i|
        is_empty << (board[king_pos[0]][i].piece == ' ')
      end
    end

    is_empty.all?(true)
  end

  def not_yet_moved(king, rook)
    king.moved == false && rook.moved == false
  end

  # castleable? makes sure that all the conditions of castling
  # are met before letting a castling be performed
  def castlable?(board, king, rook, enemy)
    not_yet_moved(king, rook) && !(check?(board, king, enemy))
  end
end