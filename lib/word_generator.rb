# Class to generate a solution_word from database sourced from external file
class WordGenerator
  attr_reader :word_database

  WORD_FILE = File.open('google-10000-english.txt')

  def initialize
    @word_database = WORD_FILE.readlines.select { |word| word if word.chomp.size.between?(5, 12) }
  end

  def getting_solution
    word_database.sample.chomp
  end
end
