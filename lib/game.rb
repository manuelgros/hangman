require './lib/player'
require './lib/messageable'
require './lib/game_logic'

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

  def self.star_game
    Game.new.run_full_game
  end

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
