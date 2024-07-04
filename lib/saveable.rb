require './lib/messageable'

# Saveable Module for save / load function of game progress
module Saveable
  include Messageable
  def self.load_game
    save_game = YAML.load_file('save_game/save_file.yaml', permitted_classes: [Game, Player])
    save_game.run_full_game
  end

  def self.want_to_load
    puts 'There is a saved game. Do you want to continue? Y for yes'
    if gets.chomp == 'y'
      load_game
    else
      Game.new.run_full_game
    end
  end

  private

  def save_game(game)
    filename = 'save_game/save_file.yaml'

    File.open(filename, 'w') do |file|
      file.puts game.to_yaml
    end
    puts prompt_message('game_saved')
    exit
  end
end
