require './lib/notifications'

# Player Class
class Player
  include Notificationable

  def getting_input(type)
    print prompt_message(type)
    validate_guess(gets.chomp.to_s.downcase)
  end

  def validate_guess(guess)
    return guess if guess.match?(/\A[a-zA-Z]+\z/)

    puts prompt_message('error')
    getting_input('guess')
  end
end
