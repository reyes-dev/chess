require_relative 'lib/board.rb'
require_relative 'lib/team.rb'
require_relative 'lib/pieces.rb'
require_relative 'lib/gameplay.rb'
require_relative 'lib/checkmate.rb'

GamePlay.new.play(Board.new)