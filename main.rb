require_relative 'lib/board'
require_relative 'lib/team'
require_relative 'lib/pieces'
require_relative 'lib/gameplay'
require_relative 'lib/checkmate'
require_relative 'lib/saving'
require 'colorize'

class Chess
  include Saving
  attr_accessor :game, :board

  def initialize(game, board)
    @game = game
    @board = board
  end

  def start
    @game.play(@board)
  end

  def start_msg
    puts 'Welcome to Ruby Chess!'.colorize(:light_red)
    puts ' '
    puts 'Each turn you will have to enter two inputs.'
    puts ' '
    puts 'Step One: '.colorize(:light_red)
    puts 'Enter the coordinates of the piece you want to move.'
    puts ' '
    puts 'Step Two: '.colorize(:light_red)
    puts 'Enter the coordinates of the square you want to land on.'
    puts ' '
    puts 'Enter one of the following to play: '
    puts '   [1]'.colorize(:light_red) + ' to play a ' + 'new game'.colorize(:light_red)
    puts '   [2]'.colorize(:light_red) + ' to load a ' + 'saved game'.colorize(:light_red)
    puts ' '
    puts ' '
  end

  def input_choice
    loop do
      choice = gets.chomp
      if choice.match?(/^1{1}$/)
        start
      elsif choice.match?(/^2{1}$/)
        load_game
      end
    end
  end

  def start_game
    start_msg
    input_choice
  end
end

Chess.new(Game.new, Board.new).start_game