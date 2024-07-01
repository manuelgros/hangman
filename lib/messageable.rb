require 'colorize'

# Module that provides all game notifications and messages
module Messageable
  def game_message(message)
    {
      'game_starts' => "Your secret word has #{solution.size} letters. Good luck!",
      'lifes_left' => "#{lifes} lifes left.\n".green,
      'last_try' => 'ONLY 1 Life LEFT!'.red,
      'solution' => "The solution was #{solution.upcase}",
      'player_won' => "You got it! Solution: #{solution.upcase}.  Lifes left: #{lifes}. Great job!".green,
      'player_lost' => "You are out of lifes. The solution was #{solution.upcase}. You'l get it next time!".red,
      'game_saved' => 'Your game has been saved. See you next time, bye!'
      
    }[message]
  end

  def prompt_message(message)
    {
      'guess' => 'Type in your guess or SAVE to save game: ',
      'again' => 'Do you want to play again? Type Y for yes: ',
      'error' => "\nUnvalid guess! Please make sure you only type either a single letter of the english alphabet
or a full word if you wish to guess solve.\n".yellow,
      'load_game' => 'There is a saved game. Do you want to continue? Y for yes'
    }[message]
  end
end
