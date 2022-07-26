class Check
  # Discovers a king is in check by iterating through the board
  # and generating legals each piece of the enemy team
  #  any of the legal squares any piece contains the King,
  # it can be attacked next turn, and is thus in check.
  def check?(board, king, next_turn)
    check = false

    board.each do |row, columns|
      columns.each do |column, square|
        next unless square.piece.team == next_turn

        square.piece.generate_legals([row, column], board)
        square.piece.legals.each do |sqr|
          check = true if board[sqr[0]][sqr[1]].piece == king
        end
      end
    end

    check
  end
end
