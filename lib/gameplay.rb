require_relative 'board.rb'
require_relative 'team.rb'
require_relative 'pieces.rb'

class GamePlay
  attr_accessor :old_pos, :new_pos
  
  def initialize
    @old_pos = nil
    @new_pos = nil
  end

  def set_positions
    puts 'Enter starting position: '
    @old_pos = gets.chomp.split('').map(&:to_i)
    puts 'Enter where you want to go: '
    @new_pos = gets.chomp.split('').map(&:to_i)
  end

  def move_from(start, board)
    board[start[0]][start[1]].piece = ' '
    board[start[0]][start[1]].space = " #{board[start[0]][start[1]].piece} ".colorize(background: board[start[0]][start[1]].color)
  end

  def move_to(chessman, finish, board)
    board[finish[0]][finish[1]].piece = chessman
    board[finish[0]][finish[1]].space = " #{board[finish[0]][finish[1]].piece.symbol} ".colorize(background: board[finish[0]][finish[1]].color)
  end

  def play(gameboard)
    loop do
      gameboard.display_board
      board = gameboard.board
      set_positions
      chessman = board[@old_pos[0]][@old_pos[1]].piece
      chessman.generate_legals(@old_pos, board)
      legal = chessman.legal_moves.any?([@new_pos[0], @new_pos[1]])
      chessman.legal_moves.clear unless legal
      redo unless legal
      move_from(@old_pos, board)
      move_to(chessman, @new_pos, board)
      chessman.legal_moves.clear
      chessman.instance_of?(Pawn) ? chessman.moved_once = true : nil
    end
  end 
end