# Handles the display of messages to the player.
module Display
  def introduction
    puts "
    Hangman is a game where you the player must guess individual
    letters until you fully spell out the selected hidden word.

    The word will be hidden with underscores, each underscore obscuring an individual letter.

    Correct guesses will uncover the corresponding letter in the word.
    Incorrect guesses will be tallied and if you reach 8 incorrect guesses you lose.

    During any turn, entering 'save' will provide a save code that will load a game back to the current state.
    "
  end

  def show_clue(word, guessed, missed)
    chars = word.chars
    clue = chars.map do |char|
      guessed[char.to_sym] ? char : "_"
    end

    puts "\n"
    puts "Clue: #{clue.join(' ')}"
    puts "Incorrect #{missed.size}/8: #{missed.keys.join(' ')}"
    puts "\n"

    !clue.join.match?("_")
  end

  def message(reason, string = nil)
    case reason
    when "new_game" then puts "Enter '1' to start a new game. Enter '2' to load from a save code."
    when "saved" then puts "To load this game in the future, load Save ##{string}:"
    when "saves_avail" then puts "Saves available: #{string}"
    when "load_save_num" then puts "Choose a save listed above:"
    when "loaded" then puts "Saved game successfully loaded. Saved file will be removed. Good luck!"
    when "invalid_code" then puts "Invalid code. Enter just the number of the save"
    when "guessed" then puts "This letter has already been guessed."
    when "invalid" then puts "Only a single letter from A-Z are accepted as guesses."
    when "req_letter" then puts "Please enter your guess:"
    when "win" then puts "\nCongratulations! You've figured out the secret word!"
    when "lose" then puts "\nSorry, you've run out of guesses. The word was '#{string}'. Better luck next time!"
    else puts "Dev input the wrong message code. Go yell at him."
    end
  end
end
