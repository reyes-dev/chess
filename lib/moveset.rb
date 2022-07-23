module Cardinal

  def check_team(x, y, board)
    board[x][y].piece.team if board[x][y].piece != ' '
  end

  def same_team(x, y, init, board)
    board[init[0]][init[1]].piece.team == check_team(x, y, board)
  end
  # Four helper methods that add all the directions that
  # The Rook piece is allowed to move to legals
  # Code is in place to break loop if square is filled by team
  # And to stop the loop after adding an enemy team-filled square
  def upwards_legals(init, board)
    (init[0] + 1).upto(8) do |x|
      break if same_team(x, init[1], init, board) # break before adding team piece
      @legals << [x, init[1]]
      break if board[x][init[1]].piece != ' ' # break after adding enemy piece
    end
  end

  def downwards_legals(init, board)
    (init[0] - 1).downto(1) do |x|
      break if same_team(x, init[1], init, board)
      @legals << [x, init[1]]
      break if board[x][init[1]].piece != ' '
    end
  end

  def rightwards_legals(init, board)
    (init[1] + 1).upto(8) do |y|
      break if same_team(init[0], y, init, board)
      @legals << [init[0], y]
      break if board[init[0]][y].piece != ' '
    end
  end

  def leftwards_legals(init, board)
    (init[1] - 1).downto(1) do |y|
      break if same_team(init[0], y, init, board)
      @legals << [init[0], y]
      break if board[init[0]][y].piece != ' '
    end
  end

  def cardinal_legals(init, board)
    upwards_legals(init, board)
    downwards_legals(init, board)
    rightwards_legals(init, board)
    leftwards_legals(init, board)
  end
end

module Diagonal
  def directions
    [[1, -1], [1, 1], [-1, 1], [-1, -1]]
  end
  # Determines if the next diagonal square
  # is occupied by a friendly piece
  def friendly?(init, chosen, board, dir)
    unless out_of_bounds?(init, dir)
      board[init[0] + dir[0]][init[1] + dir[1]].piece.team == board[chosen[0]][chosen[1]].piece.team
    end
  end
  # Called after pushing a square
  def pushed_enemy?(tile, board)
    board[tile[0]][tile[1]].piece != ' '
  end
  # x, y coordinates on board can only be between 1 and 8
  # the arrays in directions are passed as dir
  def out_of_bounds?(start, dir)
    !((start[0] + dir[0]).between?(1, 8) && (start[1] + dir[1]).between?(1, 8))
  end
  # A loop that pushes diagonal spaces based on if 
  # they exist, are empty, hold friendly pieces 
  # or hold an enemy piece
  def find_diagonals(start, board, dir)
    legal_diags = []

    loop do
      if out_of_bounds?(start, dir) || friendly?(start, start, board, dir)
        break
      elsif legal_diags.empty? # cannot call last on empty array
        legal_diags << (0..1).map { |i| start[i] + dir[i] }
        break if pushed_enemy?(legal_diags.last, board)
      else
        break if out_of_bounds?(legal_diags.last, dir)
        # Called on next diag tile
        break if friendly?(legal_diags.last, start, board, dir)
        # Since we ruled out hypothetical out of bounds tiles and tiles with team pieces
        # either empty tiles or tiles with enemy pieces are added
        legal_diags << (0..1).map { |i| legal_diags.last[i] + dir[i] }
        # Rook can't advanced past tne first hostile square
        break if pushed_enemy?(legal_diags.last, board)
      end
    end

    legal_diags.each { |e| @legals << e }
  end

  def diagonal_legals(start, board)
    directions.each { |direction| find_diagonals(start, board, direction) }
  end
end

module EightMoves
  def different_teams?(start, fin, board)
    board[fin[0]][fin[1]].piece.team != board[start[0]][start[1]].piece.team
  end
  # Using Knight's coordinate, combine with each possible move
  def combine_moves(start)
    0.upto(7) { |n| @legals << (0..1).map { |i| start[i] + possible_moves[n][i] } }
  end
  # Filters illegal moves out of @legals
  def filter_moves(start, board)
    # Filters by keeping arrays where both elements are between 1 and 8
    @legals.select! { |sqr| sqr[0].between?(1, 8) && sqr[1].between?(1, 8) }
    # Further filter out squares with friendly pieces
    @legals.select! { |sqr| different_teams?(start, sqr, board) }
  end

  def eight_legals(start, board)
    combine_moves(start)
    filter_moves(start, board)
  end
end

module PawnMovement
  # Uses enemy? method from NeighborTile module
  # Adds first and second tile ahead of pawn to @legals
  def white_legal_forwards(board, init)
    @legals << [init[0] + 1, init[1]] unless enemy?(board, init, [1, 0])
    @legals << [init[0] + 2, init[1]] unless @moved == true || enemy?(board, init, [2, 0])
  end

  def black_legal_forwards(board, init)
    @legals << [init[0] - 1, init[1]] unless enemy?(board, init, [-1, 0])
    @legals << [init[0] - 2, init[1]] unless @moved == true || enemy?(board, init, [-2,0])
  end

  def w_m
    [[1, -1], [1, 1]]
  end
  # Adds diagonal adjacent tile to @legals only if it holds enemy piece
  def white_legal_diag(board, init)
    w_m.each { |m| @legals << [init[0] + m[0], init[1] + m[1]] if enemy?(board, init, m) }
  end

  def b_m
    [[-1, 1], [-1, -1]]
  end

  def black_legal_diag(board, init)
    b_m.each { |m| @legals << [init[0] + m[0], init[1] + m[1]] if enemy?(board, init, m) }
  end

  def white_moves(board, init)
    white_legal_forwards(board, init)
    white_legal_diag(board, init)
  end

  def black_moves(board, init)
    black_legal_forwards(board, init)
    black_legal_diag(board, init)
  end
end