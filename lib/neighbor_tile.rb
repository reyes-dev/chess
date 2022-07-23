module NeighborTile
  # Checks if the combined arrays actually represent
  # an existent coordinate on an 8x8 board
  def in_bounds?(init, adj)
    ((init[0] + adj[0]).between?(1, 8) && (init[1] + adj[1]).between?(1, 8))
  end
  # Returns the adjacent square object
  # Used in enemy?
  def adj_square(board, init, adj)
    board[init[0] + adj[0]][init[1] + adj[1]] if in_bounds?(init, adj)
  end
  # Check for empty squares
  def no_piece?(square)
    square.nil? || square.piece == ' '
  end

  def enemy?(board, init, adj)
    sqr = adj_square(board, init, adj)
    sqr.piece.team != board[init[0]][init[1]].piece.team unless no_piece?(sqr)
  end
end