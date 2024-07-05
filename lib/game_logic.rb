# Module holding game logic and operations
module GameLogic
  private

  def check_input(input)
    if input == 'save'
      save_game(self, create_save_slots)
    else
      check_guess(input)
    end
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
