module EnPassant
  # left and right squares
  def tiles
    [[0, -1], [0, 1]]
  end
  # Returns the square that pawn stepped over
  def sq_stepped_over(pawn, init)
    pawn == 'white' ? [init[0] + 1, init[1]] : [init[0] - 1, init[1]]
  end
  # An adjacent piece is given en passant ability
  def allow_passant(board, fin, adj)
    piece = board[fin[0] + adj[0]][fin[1] + adj[1]].piece
    piece.en_passant_allowed = true if piece.instance_of?(Pawn)
  end
  # Square that pawn that double stepped lands on
  def store_dbl(gb, board, fin)
    gb.dbl_step_pawn = board[fin[0]][fin[1]]
  end
  # Square that Pawn that double stepped over is stored
  def store_step(gb, pawn_team, init)
    gb.stepped_over = sq_stepped_over(pawn_team, init)
  end

  def setup_passant(gb, board, pawn, init, fin, adj)
    allow_passant(board, fin, adj)
    store_dbl(gb, board, fin)
    store_step(gb, pawn, init)
  end
  # Validates that the landing square is 
  # two spaces away from the start
  def double_step?(pawn, init, fin)
    pawn == 'white' ? [init[0] + 2, init[1]] == [fin[0], fin[1]] : [init[0] - 2, init[1]] == [fin[0], fin[1]]
  end
  # Allows setup_passant to be called if pawn double stepped
  # and landed on a square where either adjacent side holds an enemy
  def passantable?(board, pawn, init, fin, adj)
    enemy?(board, fin, adj) && double_step?(pawn, init, fin)
  end

  def en_passantable(gb, board, pawn, init, fin)
    tiles.each { |t| setup_passant(gb, board, pawn.team, init, fin, t) if passantable?(board, pawn.team, init, fin, t) }
  end
  # @new_pos, or the desired landing square, is passed as fin
  def do_ep?(gb, fin)
    @en_passant_allowed && fin == gb.stepped_over
  end
  # A pawn can now move to a double-stepped-over square
  # Capturing the enemy double-stepped pawn in the process
  def perform_ep(gb)
    @legals << gb.stepped_over
    gb.dbl_step_pawn.piece = ' '
    gb.dbl_step_pawn.space = " #{gb.dbl_step_pawn.piece.symbol} ".colorize(background: gb.dbl_step_pawn.color)
    @en_passant_allowed = false
  end

  def en_passant(gb, fin)
    perform_ep(gb) if do_ep?(gb, fin)
  end
end