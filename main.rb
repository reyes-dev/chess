require_relative 'lib/board'
require_relative 'lib/pieces'
require_relative 'lib/gameplay'
require_relative 'lib/checkmate'
require 'colorize'

class Chess
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

  def self.save(game, board)
    puts 'Enter save game filename: '
    save_name = gets.chomp.downcase
    File.open("saves/#{save_name}.yaml", 'w') { |file| file.write(game.to_yaml, board.to_yaml) }
  end

  def setup_loaded_board(board, data)
    board.board = data[:board]
    board.dbl_step_pawn = data[:dbl_step_pawn]
    board.stepped_over = data[:stepped_over]
    board.white_king = data[:white_king]
    board.white_rook1 = data[:white_rook1]
    board.white_rook2 = data[:white_rook2]
    board.black_king = data[:black_king]
    board.black_rook1 = data[:black_rook1]
    board.black_rook2 = data[:black_rook2]
  end

  def load_game
    begin
    loaded = []
    if Dir.children('./saves').empty?
      puts "No files!".colorize(:light_blue) + ("\n"*4)
      start_game
    end
    puts Dir.children('./saves').map { |fn| fn.gsub('.yaml', '') }
    puts 'Enter filename you want to load: '
    load_name = gets.chomp.downcase
    YAML.load_stream(File.read("saves/#{load_name}.yaml")) { |doc| loaded << doc }
    loaded_game = Game.new(loaded[0][:turn], loaded[0][:next_turn])
    loaded_board = Board.new
    setup_loaded_board(loaded_board, loaded[1])
    Chess.new(loaded_game, loaded_board).start
    rescue
      retry
    end
  end
end

Chess.new(Game.new, Board.new).start_game
