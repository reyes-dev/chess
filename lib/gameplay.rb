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
  end

  def set_old_position
    loop do
      puts "\n"
      print 'Enter starting position: '
      @old_pos = gets.chomp.split('').map(&:to_i)
      break if @old_pos.join.match?(/^[1-8][1-8]$/)
    end
  end

  def set_new_position
    loop do
      print 'Enter landing position: '
      @new_pos = gets.chomp.split('').map(&:to_i)
      break if @new_pos.join.match?(/^[1-8][1-8]$/)
    end
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
    chessman.legal_moves.any?([landing[0], landing[1]])
  end

  def play(gameboard)
    loop do
      puts "    --#{@turn}'s turn--\n"
      puts "\n"

      gameboard.display_board
      board = gameboard.board
      set_old_position
      chessman = board[@old_pos[0]][@old_pos[1]].piece
      redo if chessman == " "
      redo unless chessman.team == @turn
      set_new_position
      chessman.generate_legals(@old_pos, board)
      chessman.legal_moves.clear unless legal?(chessman, @new_pos)
      redo unless legal?(chessman, @new_pos)
      move_from(@old_pos, board)
      move_to(chessman, @new_pos, board)
      chessman.legal_moves.clear
      chessman.instance_of?(Pawn) ? chessman.moved_once = true : nil
      switch_turns

      puts "\n"
    end
  end 
end