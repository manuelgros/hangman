require './lib/messageable'

# Player Class
class Player
  include Messageable

  def getting_input(type)
    print prompt_message(type)
    validate_input(gets.chomp.to_s.downcase)
  end

  private

  def validate_input(guess)
    return guess if guess.match?(/\A[a-zA-Z]+\z/)

    puts prompt_message('error')
    getting_input('guess')
  end
end
