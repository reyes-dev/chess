module Cardinal
    # Returns the Team (Black or White) of the Piece 
  # at the given coordinate unless it's an empty space
  def check_team(x, y, board)
    board[x][y].piece.team if board[x][y].piece != ' '
  end
  # Four helper methods that add all the directions that
  # The Rook piece is allowed to move to legal_moves
  # Code is in place to break loop if square is filled by team
  # And to stop the loop after adding an enemy team-filled square
  def upwards_legals(start, board)
    (start[0] + 1).upto(8) do |x|
      break if board[start[0]][start[1]].piece.team == check_team(x, start[1], board)
      @legal_moves << [x, start[1]]
      break if board[x][start[1]].piece != ' '
    end
  end

  def downwards_legals(start, board)
    (start[0] - 1).downto(1) do |x|
      break if board[start[0]][start[1]].piece.team == check_team(x, start[1], board)
      @legal_moves << [x, start[1]]
      break if board[x][start[1]].piece != ' '
    end
  end

  def rightwards_legals(start, board)
    (start[1] + 1).upto(8) do |y|
      break if board[start[0]][start[1]].piece.team == check_team(start[0], y, board)
      @legal_moves << [start[0], y]
      break if board[start[0]][y].piece != ' '
    end
  end

  def leftwards_legals(start, board)
    (start[1] - 1).downto(1) do |y|
      break if board[start[0]][start[1]].piece.team == check_team(start[0], y, board)
      @legal_moves << [start[0], y]
      break if board[start[0]][y].piece != ' '
    end
  end

  def cardinal_legals(start, board)
    upwards_legals(start, board)
    downwards_legals(start, board)
    rightwards_legals(start, board)
    leftwards_legals(start, board)
  end
end

module Diagonal
  def directions
    [[1, -1], [1, 1], [-1, 1], [-1, -1]]
  end

  def friendly?(start, chosen, board, dir)
    unless board[start[0] + dir[0]][start[1] + dir[1]].nil?
      board[start[0] + dir[0]][start[1] + dir[1]].piece.team == board[chosen[0]][chosen[1]].piece.team
    end
  end

  def enemy?(tile, board)
    board[tile[0]][tile[1]].piece != ' '
  end

  def out_of_bounds?(start, dir)
    !((start[0] + dir[0]).between?(1, 8) && (start[1] + dir[1]).between?(1, 8))
  end

  def find_diagonals(start, board, dir)
    legal_diags = []

    loop do
      if out_of_bounds?(start, dir) || friendly?(start, start, board, dir)
        break
      elsif legal_diags.empty?
        legal_diags << (0..1).map { |i| start[i] + dir[i] }
        break if enemy?(legal_diags.last, board)
      else
        break if out_of_bounds?(legal_diags.last, dir)
        break if friendly?(legal_diags.last, start, board, dir)
        legal_diags << (0..1).map { |i| legal_diags.last[i] + dir[i] }
        break if enemy?(legal_diags.last, board)
      end
    end

    legal_diags.each { |e| @legal_moves << e }
  end

  def diagonal_legals(start, board)
    directions.each { |direction| find_diagonals(start, board, direction) }
  end
end

module KnightMovement
  # Imitates the L-shape Knight's can move in
  def possible_moves
    [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end
  # Compares chosen piece to piece on a landing spot
  # Returning true when both squares aren't the same team
  def check_team(start, fin, board)
    board[fin[0]][fin[1]].piece.team != board[start[0]][start[1]].piece.team
  end

  def combine_moves(start)
    # Using chosen piece's coordinate, combine with each possible move
    0.upto(7) { |n| @legal_moves << (0..1).map { |i| start[i] + possible_moves[n][i] } }
  end
  # Gives all the moves Knight is allowed to make
  # From it's current position on the board
  def filter_moves(start, board)
    # Filter that result by keeping arrays where both elements are between 1 and 8
    @legal_moves.select! { |sqr| sqr[0].between?(1, 8) && sqr[1].between?(1, 8) }
    # Further filter out squares with friendly pieces
    @legal_moves.select! { |sqr| check_team(start, sqr, board) }
  end

  def knight_legals(start, board)
    combine_moves(start)
    filter_moves(start, board)
  end
end