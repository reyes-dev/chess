module RooksAndKings
  def current_king(gb, turn)
    turn == 'white' ? gb.white_king : gb.black_king
  end

  def get_white_rook(gb, king_pos, fin)
    king_pos[1] > fin[1] ? gb.white_rook1 : gb.white_rook2
  end

  def get_black_rook(gb, king_pos, fin)
    king_pos[1] > fin[1] ? gb.black_rook1 : gb.black_rook2
  end

  def get_rook(gb, team, king_pos, fin)
    team == 'white' ? get_white_rook(gb, king_pos, fin) : get_black_rook(gb, king_pos, fin)
  end

  def get_white_pos(king_pos, fin)
    king_pos[1] > fin[1] ? [1, 1] : [1, 8]
  end

  def get_black_pos(king_pos, fin)
    king_pos[1] > fin[1] ? [8, 1] : [8, 8]
  end

  def rook_pos(team, king_pos, fin)
    team == 'white' ? get_white_pos(king_pos, fin) : get_black_pos(king_pos, fin)
  end
end