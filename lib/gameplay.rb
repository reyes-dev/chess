require_relative 'board.rb'
require_relative 'team.rb'
require_relative 'pieces.rb'

class GamePlay
  attr_accessor :old_pos, :new_pos

  def initialize
    @old_pos = nil
    @new_pos = nil
    @turn = 'white'
    @next_turn = 'black'
    @letters = {
      "a" => 1,
      "b" => 2,
      "c" => 3,
      "d" => 4,
      "e" => 5,
      "f" => 6,
      "g" => 7,
      "h" => 8
    }
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
    board[finish[0]][finish[1]].space = " #{board[finish[0]][finish[1]].piece.symbol} ".colorize(background: board[finish[0]][finish[1]].color)
  end

  def switch_turns
    @turn, @next_turn = @next_turn, @turn
  end

  def legal?(chessman, landing)
    chessman.legals.any?([landing[0], landing[1]])
  end

  def convert_letter(char)
    char[0] = @letters[char[0]]
    char.map!(&:to_i).reverse!
  end

  def play(gameboard)
    loop do
      puts "       --#{@turn}'s turn--\n"
      puts "\n"

      gameboard.display_board
      board = gameboard.board
      set_old_position
      chessman = board[@old_pos[0]][@old_pos[1]].piece
      redo if chessman == " "
      redo unless chessman.team == @turn
      set_new_position
      chessman.generate_legals(@old_pos, board)
      chessman.en_passant(gameboard, @new_pos) if chessman.instance_of?(Pawn)
      chessman.legals.clear unless legal?(chessman, @new_pos)
      redo unless legal?(chessman, @new_pos)
      move_from(@old_pos, board)
      move_to(chessman, @new_pos, board)
      chessman.promote?(chessman, @new_pos, board, @turn) if chessman.instance_of?(Pawn)
      chessman.legals.clear
      chessman.instance_of?(Pawn) ? chessman.moved = true : nil
      chessman.en_passantable(gameboard, board, chessman, @old_pos, @new_pos) if chessman.instance_of?(Pawn)
      switch_turns

      puts "\n"
    end
  end
end