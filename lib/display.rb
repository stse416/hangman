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
  end

  def show_guessed(hash)
    puts "Guessed letters:  { #{hash.keys.join('  ')} }"
  end

  def show_clue(guessed, missed)
    chars = @word.chars
    clue = chars.map do |char|
      guessed[char.to_sym] ? char : "_"
    end
    puts "Clue: #{clue.join(' ')}"
    puts "Incorrect: #{missed.keys.join(' ')}"
  end
end
