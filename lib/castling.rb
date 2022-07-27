require_relative 'pieces.rb'
require_relative 'checkmate.rb'

class Castling < Check
  def onto_attacked_sqr?(board, king, init, fin, enemy)
    # Create a deep copy of the board
    fake_board = board.deep_dup
    # Move the king two squares over to its landing spot
    fake_board[init[0]][init[1]].piece = ' '
    fake_board[fin[0]][fin[1]].piece = king
    # If king is in check, it's on an attacked square
    check?(fake_board, king, enemy)
  end

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
  # Checks if the squares between king and rook are all empty
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
  # Affirms the condition that neither king nor rook
  # have moved yet in order to allow castling
  def not_yet_moved(king, rook)
    king.moved == false && rook.moved == false
  end

  # castleable? makes sure that all the conditions of castling
  # are met before letting a castling be performed
  def castlable?(board, king, rook, king_pos, rook_pos, fin, enemy)
    !over_attacked_sqr?(board, king_pos, rook_pos, enemy) && !onto_attacked_sqr?(board, king, king_pos, fin, enemy) && squares_empty?(board, king_pos, rook_pos) && not_yet_moved(king, rook) && !(check?(board, king, enemy))
  end

  def add_legal(king_pos, rook_pos)
    king_pos[1] > rook_pos[1] ? @legals << [king_pos[0], king_pos[1] - 2] : @legals << [king_pos[0], king_pos[1] + 2]
  end
  # Adds the square two squares away from kings current position to legals
  # all conditions for castling are met
  def allow_castle(board, king, rook, king_pos, rook_pos, fin, enemy)
    add_legal(king_pos, rook_pos) if castlable?(board, king, rook, king_pos, rook_pos, fin, enemy)
  end
  # Return square coordinate that king stepped over
  def sq_stepped_over(king_pos, rook_pos)
    king_pos[1] > rook_pos[1] ? [king_pos[0], king_pos[1] - 1] : [king_pos[0], king_pos[1] + 1]
  end
  # Move the rook to where king passed over
  def perform_castle(board, rook, king_pos, rook_pos)
    sq = sq_stepped_over(king_pos, rook_pos)
    board[rook_pos[0]][rook_pos[1]].piece = ' '
    board[rook_pos[0]][rook_pos[1]].space = " #{board[rook_pos[0]][rook_pos[1]].piece.symbol} ".colorize(background: board[rook_pos[0]][rook_pos[1]].color)
    board[sq[0]][sq[1]].piece = rook
    board[sq[0]][sq[1]].space = " #{rook.symbol} ".colorize(background: board[sq[0]][sq[1]].color)
  end

  def landing_sq(king_pos, rook_pos)
    king_pos[1] > rook_pos[1] ? [king_pos[0], king_pos[1] - 2] : [king_pos[0], king_pos[1] + 2]
  end

  def do_castle(board, rook, king_pos, rook_pos, fin)
    perform_castle(board, rook, king_pos, rook_pos) if fin == landing_sq(king_pos, rook_pos)
  end

  def castle(board, king, rook, king_pos, rook_pos, fin, enemy)
    do_castle(board, rook, king_pos, rook_pos, fin) if castlable?(board, king, rook, king_pos, rook_pos, fin, enemy)
  end
end