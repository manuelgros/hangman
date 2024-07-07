require 'colorize'

# Module that provides all game notifications and messages
module Messageable
  def game_message(message)
    {
      'game_starts' => "\nYour secret word has #{solution.size} letters. Good luck!",
      'lifes_left' => "#{lifes.to_s.green} lifes left.\n",
      'last_try' => 'ONLY 1 Life LEFT!'.red,
      'solution' => "The solution was #{solution.upcase}",
      'player_won' => "You got it! Solution: #{solution.upcase}. \nLifes left: #{lifes}.\nGreat job!".green,
      'player_lost' => "You are out of lifes. The solution was #{solution.upcase}. You'l get it next time!".red
    }[message]
  end

  def prompt_message(message)
    {
      'guess' => 'Type in your guess or SAVE to save game: ',
      'again' => "Do you want to play again?\n#{'[Y]'.green} YES\n#{'[N]'.red} NO\n",
      'error' => "\nUnvalid guess! Please make sure you only type either a single letter of the english alphabet
or a full word if you wish to guess solve.\n".yellow,
      'game_saved' => 'Your game has been saved. See you next time, bye!'
    }[message]
  end
end
