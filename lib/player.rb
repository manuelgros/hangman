require './lib/notifications'

# Player Class
class Player
  include Notificationable

  def getting_guess
    print prompt_message('guess_prompt')
    validate_guess(gets.chomp.to_s.downcase)
  end

  def validate_guess(guess)
    return guess if guess.match?(/\A[a-zA-Z]+\z/)

    puts prompt_message('guess_error')
    getting_guess
  end
end
