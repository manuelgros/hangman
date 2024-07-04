require './lib/messageable'

# Saveable Module for save / load function of game progress
module Saveable
  include Messageable
  # New save game feature. It works, but I feel code could be more elegant. Also better in own module/class
  def save_game(game)
    # save = game.to_yam
    filename = 'save_game/save_file.yaml'

    File.open(filename, 'w') do |file|
      file.puts game.to_yaml
    end
    puts prompt_message('game_saved')
    exit
  end

  def self.load_game
    # save_file = File.open 'save_game/save_file.yaml'
    save_game = YAML.load_file('save_game/save_file.yaml', permitted_classes: [Game, Player])
    # save_file.close
    # File.delete(save_file)
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
end
