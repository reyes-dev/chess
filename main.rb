require_relative 'lib/board.rb'
require_relative 'lib/team.rb'
require_relative 'lib/pieces.rb'

board = Board.new
board.display_board
board.moving
puts "\n"