require './lib/player'
require './lib/notifications'

# Game class
class Game
  include Notificationable

  attr_reader :solution, :player
  attr_accessor :last_guess, :tries, :wordboard

  def initialize
    @solution = WordGenerator.new.getting_solution
    @player = Player.new
    @last_guess = ''
    @wordboard = create_wordboard(solution)
    @tries = 10
  end

  # Solution doesn't work because it returns only first match, even if guess is included in solution multiple times
  # However, I think direction is right.
  def check_guess(guess)
    if guess.size == 1 && solution.include?(guess)
      solution.each_char.with_index { |letter, idx| wordboard[idx] = guess if letter.eql?(guess) }
    elsif guess == solution
      self.wordboard = guess.split('')
    else
      @tries -= 1
    end
  end

  # works currently only with single letter guess. Implement whole word solve later
  def play_round
    puts tries > 1 ? game_message('tries_left') : game_message('last_try')
    last_guess = player.getting_guess
    check_guess(last_guess)
    display_board(wordboard)
    # @tries -= 1
  end

  def run_full_game
    puts game_description
    puts game_message('game_starts')
    display_board(wordboard)
    play_round until game_over?
    puts game_message('solution')
  end

  def game_over?
    wordboard.join == solution || tries.zero?
  end

  def create_wordboard(word)
    Array.new(word.size, '_')
  end

  # Maybe split board display and letters left into seperate methods. Just storing here.
  def display_board(array)
    puts "\n\n#{array.join(' ')}   #{array.count('_')} letters left\n\n"
  end

  # Should Display class be created?
end
