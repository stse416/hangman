# Handles the display of messages to the player.
class Display
  def initialize(word)
    @word = word
  end

  def introduction
    puts "
    Hangman is a game where you the player must guess individual
    letters until you fully spell out the selected hidden word.

    The word will be hidden with underscores, each underscore obscuring an individual letter.

    Correct guesses will uncover the corresponding letter in the word.
    Incorrect guesses will be tallied and if you reach 8 incorrect guesses you lose"

    puts "\n"
    show_clue({}, {})
  end

  def show_clue(guessed, missed)
    chars = @word.chars
    clue = chars.map do |char|
      guessed[char.to_sym] ? char : "_"
    end
    puts "Clue: #{clue.join(' ')}"
    puts "Incorrect #{missed.size}/8: #{missed.keys.join(' ')}"

    !clue.join.match?("_")
  end

  def msg(reason)
    case reason
    when "guessed" then puts "This letter has already been guessed."
    when "invalid" then puts "Only a single letter from A-Z are accepted as guesses."
    when "req_letter" then puts "\nPlease enter your guess:"
    when "win" then puts "\nCongratulations! You've figured out the secret word!"
    when "lose" then puts "\nSorry, you've run out of guesses. The word was '#{@word}'. Better luck next time!"
    else puts "Dev input the wrong reason. Go yell at him."
    end
  end
end
