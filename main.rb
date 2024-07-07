# main file for Hangman application
require './lib/word_generator'
require './lib/game'
require './lib/game_description'

puts GameDescription.game_description
Game.start_game
