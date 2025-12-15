require_relative "dictionary"
require_relative "display"

# eventually load state into game

class Game
  attr_reader :word

  def initialize
    @dictionary = Dictionary.new("google-10000-english-no-swears.txt")
    @word = @dictionary.game_word
    @display = Display.new(@word)
    @guessed = []
  end

  def start_game
    @display.introduction
  end
end
