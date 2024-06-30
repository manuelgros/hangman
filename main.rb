# main file for Hangman application
require './lib/word_generator'
require './lib/game'
require './lib/game_description'
require 'pry-byebug'

puts GameDescription.game_description
Game.star_game
