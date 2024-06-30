# Game description class
class GameDescription
  def self.game_description
    %(Welcome! This is a console based version of the guessing game 'Hangman'!
You will be present with a randomly selected secret word from the english language.
Your job is, to uncover the word, by guessing the letters.
Each time you guess right, all existing instances of that letter will be revealed.
You can also try to solve the entire word at any time, if you think you know the solution.
However, if you guess wrong you lose one of your lifes. If you guess wrong 10 times, you lose.\n\n)
  end
end
