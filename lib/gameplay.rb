require_relative 'board'
require_relative 'team'
require_relative 'pieces'
require_relative 'checkmate'

class GamePlay < Check
  attr_accessor :old_pos, :new_pos

  def initialize
    @old_pos = nil
    @new_pos = nil
    @turn = 'white'
    @next_turn = 'black'
    @letters = {
      'a' => 1,
      'b' => 2,
      'c' => 3,
      'd' => 4,
      'e' => 5,
      'f' => 6,
      'g' => 7,
      'h' => 8
    }
  end

  def convert_letter(char)
    char[0] = @letters[char[0]]
    char.map!(&:to_i).reverse!
  end

  def set_old_position
    loop do
      puts "\n"
      print 'Enter starting position: '
      @old_pos = gets.chomp.split('')
      break if @old_pos.join.match?(/^[a-h][1-8]$/)
    end
    convert_letter(@old_pos)
  end

  def set_new_position
    loop do
      print 'Enter landing position: '
      @new_pos = gets.chomp.split('')
      break if @new_pos.join.match?(/^[a-h][1-8]$/)
    end
    convert_letter(@new_pos)
  end

  def move_from(start, board)
    board[start[0]][start[1]].piece = ' '
    board[start[0]][start[1]].space = " #{board[start[0]][start[1]].piece} ".colorize(background: board[start[0]][start[1]].color)
  end

  def move_to(chessman, finish, board)
    board[finish[0]][finish[1]].piece = chessman
    board[finish[0]][finish[1]].space = " #{chessman.symbol} ".colorize(background: board[finish[0]][finish[1]].color)
  end

  def switch_turns
    @turn, @next_turn = @next_turn, @turn
  end

  def legal?(chessman, landing)
    chessman.legals.any?([landing[0], landing[1]])
  end

  def kings(board)
    @white_king = board[1][5].piece
    @black_king = board[8][5].piece
  end

  def current_king(turn)
    turn == 'white' ? @white_king : @black_king
  end

  def play(gameboard)
    kings(gameboard.board)
    loop do
      puts "       --#{@turn}'s turn--\n"
      puts "\n"
      # Phase 1 -> displays board and let's player select a square
      # That isn't empty and holds a piece that matches their team
      gameboard.display_board
      board = gameboard.board
      puts "\n #{@turn} is in check! \n" if check?(board, current_king(@turn), @next_turn)
      if check?(board, current_king(@turn), @next_turn) && mate?(board, current_king(@turn), @turn, @next_turn)
        puts "\n #{@turn} is in checkmate! #{@next_turn} wins the game!"
        break
      elsif stalemate?(board, current_king(@turn), @turn, @next_turn)
        puts "\n #{@turn} is in stalemate! Game is a draw!"
        break
      end
      set_old_position
      chessman = board[@old_pos[0]][@old_pos[1]].piece
      redo if chessman == ' '
      redo unless chessman.team == @turn
      # Phase 2 -> player selects a new square to move the piece
      # a set of allowed moves is generated for selected piece
      # allows players pawn to perform an en passant
      # if conditions were met in the prior turn
      set_new_position
      chessman.generate_legals(@old_pos, board)
      chessman.en_passant(gameboard, @new_pos) if chessman.instance_of?(Pawn)
      chessman.restrict_en_passant(@turn) if chessman.instance_of?(Pawn)
      filter_legals(board, current_king(@turn), chessman, @old_pos, @next_turn)
      chessman.legals.clear unless legal?(chessman, @new_pos)
      redo unless legal?(chessman, @new_pos)
      # Phase 3 -> Moves selected piece to new position
      # Promotes if eligible Pawn, edits @moved variable and
      # Makes pawn eligible to be attacked en passant if conditions are met
      move_from(@old_pos, board)
      move_to(chessman, @new_pos, board)
      chessman.promote?(board, @new_pos, @turn) if chessman.instance_of?(Pawn)
      chessman.legals.clear
      chessman.instance_of?(Pawn) ? chessman.moved = true : nil
      chessman.en_passantable(gameboard, board, chessman, @old_pos, @new_pos) if chessman.instance_of?(Pawn)
      switch_turns

      puts "\n"
    end
  end
end
