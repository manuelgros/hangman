require './lib/player'

# Game class
class Game
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
  def compare_to_solution(guess)
    solution.each_char.with_index do |letter, idx|
      wordboard[idx] = guess if letter.eql?(guess)
    end
  end

  # works currently only with single letter guess. Implement whole word solve later
  def play_round
    puts "#{tries} tries left"
    last_guess = player.getting_guess
    compare_to_solution(last_guess) if last_guess.size.eql?(1)
    display_board(wordboard)
    @tries -= 1
    # binding.pry
  end

  # Play one game
  #   Play one round until game_end?
  # end

  def run_full_game
    puts 'Game starts'
    display_board(wordboard)
    play_round until game_over?
    puts "The solution was #{solution.upcase}"
  end

  def game_over?
    wordboard.none?('_') || tries.zero?
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
