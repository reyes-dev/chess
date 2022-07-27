require_relative 'pieces.rb'
require_relative 'checkmate.rb'

class Castling < Check
  def over_attacked_sqr?(board, king_pos, rook_pos, enemy)
    under_attack = false
    # Go through the entire board hash's 64 squares
    board.each do |row, columns|
      columns.each do |column, square|
        # If the piece on that sqr is an enemy
        next unless square.piece.team == enemy
        # If any of the legal squares match the square king moves over
        # that square is considered under attack
        square.piece.generate_legals([row, column], board)
        square.piece.legals.each do |sqr|
          # King moves leftwards (lower) towards the rook
          if king_pos[1] > rook_pos[1]
            under_attack = true if sqr == [king_pos[0], king_pos[1] - 1]
          # King moves rightwards (higher) towards the rook
          elsif king_pos[1] < rook_pos[1]
            under_attack = true if sqr == [king_pos[0], king_pos[1] + 1]
          end
        end
        square.piece.legals.clear
      end
    end

    under_attack
  end

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
  def castlable?(board, king, rook, king_pos, rook_pos, enemy)
    squares_empty?(board, king_pos, rook_pos) && not_yet_moved(king, rook) && !(check?(board, king, enemy))
  end
end