module Promotion
  def choose_promotion
    loop do
      puts "Promote to Queen, Rook, Knight or Bishop?"
      @choice = gets.chomp
      break if @choice.match?(/queen|rook|knight|bishop/)
    end
  end

  def promotion(choice, color, pawn)
    case choice
    when "queen"
      pawn.piece = Queen.new(color.to_sym, color)
    when "rook"
      pawn.piece = Rook.new(color.to_sym, color)
    when "knight"
      pawn.piece = Knight.new(color.to_sym, color)
    when "bishop"
      pawn.piece = Bishop.new(color.to_sym, color)
    end
  end

  def update_space(pawn)
    pawn.space = " #{pawn.piece.symbol} ".colorize(background: pawn.color)
  end

  def promote(board, pos, color)
    pawn = board[pos[0]][pos[1]]
    choose_promotion
    promotion(@choice, color, pawn)
    update_space(pawn)
  end
  # ready_to_promote? returns true if pawns reach end of the board
  def ready_to_promote?(color, pos)
    (color == 'white' && pos[0] == 8) || (color == 'black' && pos[0] == 1)
  end

  def promote?(board, pos, color)
    promote(board, pos, color) if ready_to_promote?(color, pos)
  end
end