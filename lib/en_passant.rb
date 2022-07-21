module EnPassant
  def tiles
    [[0, -1], [0, 1]]
  end

  def double_step?(pawn, init, fin)
    pawn == 'white' ? [init[0] + 2, init[1]] == [fin[0], fin[1]] : [init[0] - 2, init[1]] == [fin[0], fin[1]]
  end

  def sq_stepped_over(pawn, init)
    pawn == 'white' ? [init[0] + 1, init[1]] : [init[0] - 1, init[1]]
  end

  def allow_passant(board, fin, adj)
    board[fin[0] + adj[0]][fin[1] + adj[1]].piece.en_passant_allowed = true
  end

  def store_dbl(gb, board, fin)
    gb.dbl_step_pawn = board[fin[0]][fin[1]]
  end

  def store_step(gb, pawn_team, init)
    gb.stepped_over = sq_stepped_over(pawn_team, init)
  end

  def setup_passant(gb, board, pawn, init, fin, adj)
    allow_passant(board, fin, adj)
    store_dbl(gb, board, fin)
    store_step(gb, pawn, init)
  end

  def passantable?(board, pawn, init, fin, adj)
    enemy?(board, fin, adj) && double_step?(pawn, init, fin)
  end

  def en_passantable(gb, board, pawn, init, fin)
    tiles.each { |t| setup_passant(gb, board, pawn.team, init, fin, t) if passantable?(board, pawn.team, init, fin, t) }
  end

  def do_ep?(gb, fin)
    @en_passant_allowed && fin == gb.stepped_over
  end

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