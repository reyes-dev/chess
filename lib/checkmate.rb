require_relative 'deep_dup.rb'

class Check
  def check?(board, king, next_turn)
    check = false
    # Go through the entire board hash's 64 squares
    board.each do |row, columns|
      columns.each do |column, square|
        # If the piece on that sqr is an enemy
        next unless square.piece.team == next_turn
        # Determine legals which can be check for enemy king
        square.piece.generate_legals([row, column], board) 
        square.piece.legals.each do |sqr|
          # Enemy is in check if any legal squares contain the king
          check = true if board[sqr[0]][sqr[1]].piece == king
        end
      end
    end

    check
  end

  # Loop through each team piece alive on the board and generate legals
  # Create a separate, fake board to make each possible move on
  # Check on that board check? still returns true
  # If it does, meaning every possible legal move can't change
  # the result of check?, then it is mate
  def mate?(board, king, turn, next_turn)
    still_in_check = []
    # Go through the entire board hash's 64 squares
    board.each do |row, columns|
      columns.each do |column, square|
        # If the piece on that square is a team piece
        next unless square.piece.team == turn
        # Generate all the moves it can make, disregarding check for now
        square.piece.generate_legals([row, column], board)
        square.piece.legals.each do |sqr|
          # Create a deep copy of the board hash
          # to peform legal moves without altering original board
          fake_board = board.deep_dup
          fake_board[sqr[0]][sqr[1]].piece = square.piece
          fake_board[row][column].piece = ' '
          # Test if peforming a legal move leaves the board in check
          # or takes it out of check (pushes a false boolean)
          still_in_check << check?(fake_board, king, next_turn)
        end
      end
    end
    # If all possible legal moves are true, 
    # no legal moves can take the king out of check 
    still_in_check.all?(true)
  end
end