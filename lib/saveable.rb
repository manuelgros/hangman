require './lib/messageable'

# Saveable Module for save / load function of game progress
module Saveable
  include Messageable

  def create_save_slots
    slot2 = File.open('./save_game/save_slot_2.yaml', 'r')
    slot1 = File.open('./save_game/save_slot_1.yaml', 'r')
    slot3 = File.open('./save_game/save_slot_3.yaml', 'r')
    ['', slot1, slot2, slot3]
  end

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

  # def save_game(game)
  #   filename = 'save_game/save_file.yaml'

  #   File.open(filename, 'w') do |file|
  #     file.puts game.to_yaml
  #   end
  #   puts prompt_message('game_saved')
  #   exit
  # end

  def save_game(game, slots_array)
    puts 'Select slot to save curretn game'
    display_slots(slots_array)
    print 'Select slot number: '

    filename = slots_array[gets.chomp.to_i]

    File.open(filename, 'w') do |file|
      file.puts game.to_yaml
    end
    puts prompt_message('game_saved')
    exit
  end

  def show_save(file)
    return '--empty--' if File.empty?(file)

    YAML.load_file(file, permitted_classes: [Game, Player]).wordboard.join('')
  end

  def display_slots(array_with_saves)
    array_with_saves.each_with_index do |file, idx|
      next if idx.zero?

      puts "#{idx}. Slot: Current game: #{show_save(file)}"
    end
  end
end
