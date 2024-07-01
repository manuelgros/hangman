require './lib/player'
require './lib/messageable'
require './lib/game_logic'
require 'pry-byebug'

# Game class
class Game
  include Messageable
  include GameLogic

  attr_reader :solution, :player
  attr_accessor :last_guess, :lifes, :wordboard, :wrong_guesses

  def initialize
    @solution = WordGenerator.new.getting_solution
    @player = Player.new
    @last_guess = ''
    @wrong_guesses = []
    @wordboard = create_wordboard(solution)
    @lifes = 10
  end

  # New save game feature. It works, but I feel code could be more elegant. Also better in own module/class
  def save_game
    save = to_yaml
    filename = 'save_game/save_file.yaml'

    File.open(filename, 'w') do |file|
      file.puts save
    end
    puts game_message('game_saved')
    exit
  end

  def self.load_game
    save_file = File.open 'save_game/save_file.yaml'
    save_game = YAML.load_file(save_file, permitted_classes: [Game, Player])
    save_file.close
    File.delete(save_file)
    save_game.run_full_game
  end

  def self.want_to_load
    load_game if gets.chomp == 'y'
    display_board(wordboard)
  end

  def self.star_game
    if File.exist? 'save_game/save_file.yaml'
      puts 'Save game exists. Do you want to continue? '
      want_to_load
    else
      Game.new.run_full_game
    end
  end
  # End of save game feature

  def run_full_game
    puts game_message('game_starts')
    display_board(wordboard)
    play_round until game_over?
    puts lifes.zero? ? game_message('player_lost') : game_message('player_won')
    play_again
  end

  private

  def play_round
    puts lifes > 1 ? game_message('lifes_left') : game_message('last_try')
    last_guess = player.getting_input('guess')
    check_guess(last_guess)
    display_board(wordboard)
  end

  def play_again
    if player.getting_input('again') == 'y'
      Game.new.run_full_game
    else
      exit
    end
  end
end
