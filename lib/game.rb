require './lib/player'
require './lib/notifications'

# Game class
class Game
  include Notificationable

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

  def check_guess(guess)
    if guess.size == 1 && solution.include?(guess)
      solution.each_char.with_index { |letter, idx| wordboard[idx] = guess if letter.eql?(guess) }
    elsif guess == solution
      self.wordboard = guess.split('')
    else
      @lifes -= 1
      wrong_guesses << guess
    end
  end

  def play_round
    puts lifes > 1 ? game_message('lifes_left') : game_message('last_try')
    last_guess = player.getting_guess
    check_guess(last_guess)
    display_board(wordboard)
  end

  def run_full_game
    puts game_description
    puts game_message('game_starts')
    display_board(wordboard)
    play_round until game_over?
    puts lifes.zero? ? game_message('player_lost') : game_message('player_won')
  end

  def game_over?
    wordboard.join == solution || lifes.zero?
  end

  def create_wordboard(word)
    Array.new(word.size, '_')
  end

  def display_board(array)
    puts "\n\n#{array.join(' ')}   #{array.count('_')} letters left\n\n"
    puts "Already guessed: #{wrong_guesses.join(', ')}"
  end
end
