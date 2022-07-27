require_relative 'pieces.rb'
require_relative 'checkmate.rb'

class Castling < Check
  def not_yet_moved(king, rook)
    king.moved == false && rook.moved == false
  end

  # castleable? makes sure that all the conditions of castling
  # are met before letting a castling be performed
  def castlable?(board, king, rook, enemy)
    not_yet_moved(king, rook) && !(check?(board, king, enemy))
  end
end