require 'colorize'

# Module that provides all game notifications and messages
module Notificationable
  def game_description
    %(Welcome! This is a console based version of the guessing game 'Hangman'!
You will be present with a randomly selected secret word from the english language.
Your job is, to uncover the word, by guessing the letters.
Each time you guess right, all existing instances ofthat letter will be revealed.
You can also SOLVE the word at any time, if you think you know the solution.
You have 10 GUESSES per word.\n\n)
  end

  def game_message(message)
    {
      'game_starts' => "Your secret word has #{solution.size} letters. Good luck!",
      'tries_left' => "#{tries} tries left.",
      'last_try' => 'ONLY 1 TRY LEFT!'.red,
      'solution' => "The solution was #{solution.upcase}"
    }[message]
  end

  def prompt_message(message)
    {
      'guess_prompt' => 'Type in your guess or the command SOLVE: ',
      'guess_error' => "\nUnvalid guess! Please make sure you only type in a single letter of the english alphabet
or type the word SOLVE if you wish to guess the whole word.\n"
    }[message]
  end
end
