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

  def self.show_guessed(arr)
    puts "Guessed letters:  { #{arr.join('  ')} }"
  end
end

Display.show_guessed(%w[G H I P Q])
