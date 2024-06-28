# main file for Hangman application
require './lib/word_generator'
require './lib/game'
require 'pry-byebug'

Game.new.run_full_game
