require './lib/messageable'
require 'yaml'

# Saveable Module for save / load function of game progress
module Saveable
  include Messageable

  def want_to_load
    return Game.new.run_full_game if create_save_slots[1..].all? { |file| File.empty?(file) }

    puts 'Do you want to load an exisiting game or start new? L for load / N for new'
    if gets.chomp == 'l'
      select_save_game
    else
      Game.new.run_full_game
    end
  end

  private

  def create_save_slots
    slot1 = File.open('./save_game/save_slot_1.yaml', 'r')
    slot2 = File.open('./save_game/save_slot_2.yaml', 'r')
    slot3 = File.open('./save_game/save_slot_3.yaml', 'r')
    ['', slot1, slot2, slot3]
  end

  def load_game(save_slot)
    save_game = YAML.load_file(save_slot, permitted_classes: [Game, Player])
    save_game.run_full_game
  end

  def select_save_game
    display_slots(create_save_slots)
    print 'Choose save game (1-3) or type N for new game:'
    selection = gets.chomp.to_i
    if selection.between?(1, 3) && !File.empty?(create_save_slots[selection])
      load_game(create_save_slots[selection])
    else
      puts 'Unvalid selection OR empty save game, choose again...'
      select_save_game
    end
  end

  def save_game(game, slots_array)
    puts 'Select slot to save current game'
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
