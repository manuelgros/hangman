require 'colorize'

# Module that provides all game notifications and messages
module Notificationable
  def game_description
    %(Welcome! This is a console based version of the guessing game 'Hangman'!
You will be present with a randomly selected secret word from the english language.
Your job is, to uncover the word, by guessing the letters.
Each time you guess right, all existing instances of that letter will be revealed.
You can also try to solve the entire word at any time, if you think you know the solution.
However, if you guess wrong you lose one of your lifes. If you guess wrong 10 times, you lose.\n\n)
  end

  def game_message(message)
    {
      'game_starts' => "Your secret word has #{solution.size} letters. Good luck!",
      'lifes_left' => "#{lifes} lifes left.",
      'last_try' => 'ONLY 1 TRY LEFT!'.red,
      'solution' => "The solution was #{solution.upcase}",
      'player_won' => "You got it! The solution was #{solution.upcase}. Great job!".green,
      'player_lost' => "You are out of lifes. The solution was #{solution.upcase}. You'l get it next time!".red
    }[message]
  end

  def prompt_message(message)
    {
      'guess_prompt' => 'Type in your guess or the command SOLVE: ',
      'guess_error' => "\nUnvalid guess! Please make sure you only type either a single letter of the english alphabet
or a full word if you wish to guess solve.\n"
    }[message]
  end
end
