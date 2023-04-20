require_relative 'board'
require_relative 'pieces'
require_relative 'checkmate'
require_relative 'rooksandkings'

class Game < Check
  include RooksAndKings
  attr_accessor :old_pos, :new_pos

  def initialize(turn = 'white', next_turn = 'black')
    @turn = turn
    @next_turn = next_turn
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

  def set_old_position(board)
    loop do
      system 'clear'
      puts "\n"
      board.display_board
      puts "\n\n#{@turn}'s turn\n"
      puts "\n"
      puts '[Q] to Quit or [S] to Save'
      puts 'Enter starting position: '
      @old_pos = gets.chomp.split('')
      if @old_pos.join.match?(/^[a-h][1-8]$/)
        break
      elsif @old_pos.join.match?('s')
        Chess.save(self, board)
      elsif @old_pos.join.match?('q')
        exit
      end
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

  def moved_once(piece)
    piece.moved = true if [Pawn, Rook, King].any? { |klass| piece.instance_of?(klass) }
  end

  def to_yaml
    YAML.dump({
      turn: @turn,
      next_turn: @next_turn
              })
  end

  def restart_game
    loop do
      puts 'Enter [m] to return to main menu.'
      char = gets.chomp
      if char == 'm'
        Chess.new(Game.new, Board.new).start_game
        break
      end
    end
  end

  def play(gameboard)
    loop do
      # Phase 1 -> displays board and let's player select a square
      # That isn't empty and holds a piece that matches their team
      board = gameboard.board
      puts "\n #{@turn} is in check! \n" if check?(board, current_king(gameboard, @turn), @next_turn)
      if check?(board, current_king(gameboard, @turn),
                @next_turn) && mate?(board, current_king(gameboard, @turn), @turn, @next_turn)
        puts "\n #{@turn} is in checkmate! #{@next_turn} wins the game!"
        restart_game
      elsif stalemate?(board, current_king(gameboard, @turn), @turn, @next_turn)
        puts "\n #{@turn} is in stalemate! Game is a draw!"
        restart_game
      end
      set_old_position(gameboard)
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
      filter_legals(board, current_king(gameboard, @turn), chessman, @old_pos, @next_turn)
      if chessman.instance_of?(King)
        rook = get_rook(gameboard, @turn, @old_pos, @new_pos)
        rook_pos = rook_pos(@turn, @old_pos, @new_pos)
        chessman.allow_castle(board, chessman, rook, @old_pos, rook_pos, @new_pos, @next_turn)
        chessman.castle(board, chessman, rook, @old_pos, rook_pos, @new_pos, @next_turn)
      end
      chessman.legals.clear unless legal?(chessman, @new_pos)
      redo unless legal?(chessman, @new_pos)
      # Phase 3 -> Moves selected piece to new position
      # Promotes if eligible Pawn, edits @moved variable and
      # Makes pawn eligible to be attacked en passant if conditions are met
      move_from(@old_pos, board)
      move_to(chessman, @new_pos, board)
      chessman.promote?(board, @new_pos, @turn) if chessman.instance_of?(Pawn)
      chessman.legals.clear
      moved_once(chessman)
      chessman.en_passantable(gameboard, board, chessman, @old_pos, @new_pos) if chessman.instance_of?(Pawn)
      switch_turns
    end
  end

  def random_piece(board)
    pieces = []
    board.each do |row, columns|
      columns.each do |column, square|
        next unless square.piece.team == @turn
        pieces << [row, column]
      end
    end
    pieces.sample
  end

  def play_AI(gameboard)
    loop do
      if @turn == 'white'
        board = gameboard.board
        puts "\n #{@turn} is in check! \n" if check?(board, current_king(gameboard, @turn), @next_turn)
        if check?(board, current_king(gameboard, @turn),
                  @next_turn) && mate?(board, current_king(gameboard, @turn), @turn, @next_turn)
          puts "\n #{@turn} is in checkmate! #{@next_turn} wins the game!"
          restart_game
        elsif stalemate?(board, current_king(gameboard, @turn), @turn, @next_turn)
          puts "\n #{@turn} is in stalemate! Game is a draw!"
          restart_game
        end
        set_old_position(gameboard)
        chessman = board[@old_pos[0]][@old_pos[1]].piece
        redo if chessman == ' '
        redo unless chessman.team == @turn
        set_new_position
        chessman.generate_legals(@old_pos, board)
        chessman.en_passant(gameboard, @new_pos) if chessman.instance_of?(Pawn)
        chessman.restrict_en_passant(@turn) if chessman.instance_of?(Pawn)
        filter_legals(board, current_king(gameboard, @turn), chessman, @old_pos, @next_turn)
        if chessman.instance_of?(King)
          rook = get_rook(gameboard, @turn, @old_pos, @new_pos)
          rook_pos = rook_pos(@turn, @old_pos, @new_pos)
          chessman.allow_castle(board, chessman, rook, @old_pos, rook_pos, @new_pos, @next_turn)
          chessman.castle(board, chessman, rook, @old_pos, rook_pos, @new_pos, @next_turn)
        end
        chessman.legals.clear unless legal?(chessman, @new_pos)
        redo unless legal?(chessman, @new_pos)
        move_from(@old_pos, board)
        move_to(chessman, @new_pos, board)
        chessman.promote?(board, @new_pos, @turn) if chessman.instance_of?(Pawn)
        chessman.legals.clear
        moved_once(chessman)
        chessman.en_passantable(gameboard, board, chessman, @old_pos, @new_pos) if chessman.instance_of?(Pawn)
        switch_turns
      elsif @turn == 'black'
        board = gameboard.board
        puts "\n #{@turn} is in check! \n" if check?(board, current_king(gameboard, @turn), @next_turn)
        if check?(board, current_king(gameboard, @turn),
                  @next_turn) && mate?(board, current_king(gameboard, @turn), @turn, @next_turn)
          puts "\n #{@turn} is in checkmate! #{@next_turn} wins the game!"
          restart_game
        elsif stalemate?(board, current_king(gameboard, @turn), @turn, @next_turn)
          puts "\n #{@turn} is in stalemate! Game is a draw!"
          restart_game
        end
        system 'clear'
        puts
        gameboard.display_board
        puts "\n#{@turn}'s turn..."
        sleep 1
        @old_pos = random_piece(board)
        chessman = board[@old_pos[0]][@old_pos[1]].piece
        redo if chessman == ' '
        redo unless chessman.team == @turn
        chessman.generate_legals(@old_pos, board)
        filter_legals(board, current_king(gameboard, @turn), chessman, @old_pos, @next_turn)
        redo if chessman.legals.empty?
        @new_pos = chessman.legals.sample
        chessman.en_passant(gameboard, @new_pos) if chessman.instance_of?(Pawn)
        chessman.restrict_en_passant(@turn) if chessman.instance_of?(Pawn)
        if chessman.instance_of?(King)
          rook = get_rook(gameboard, @turn, @old_pos, @new_pos)
          rook_pos = rook_pos(@turn, @old_pos, @new_pos)
          chessman.allow_castle(board, chessman, rook, @old_pos, rook_pos, @new_pos, @next_turn)
          chessman.castle(board, chessman, rook, @old_pos, rook_pos, @new_pos, @next_turn)
        end
        chessman.legals.clear unless legal?(chessman, @new_pos)
        redo unless legal?(chessman, @new_pos)
        move_from(@old_pos, board)
        move_to(chessman, @new_pos, board)
        chessman.legals.clear
        moved_once(chessman)
        chessman.en_passantable(gameboard, board, chessman, @old_pos, @new_pos) if chessman.instance_of?(Pawn)
        switch_turns
      end
    end
  end
end
