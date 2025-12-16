require_relative "dictionary"
require_relative "display"

# eventually load state into game

# Game logic handler
class Game
  attr_reader :word

  def initialize
    @dictionary = Dictionary.new("google-10000-english-no-swears.txt")
    @word = @dictionary.game_word.upcase
    @display = Display.new(@word)
    @guessed = {}
    @missed = {}
    @game_over = false
  end

  def start_game
    @display.introduction

    start_turn while !@game_over && @missed.size < 8
  end

  def start_turn
    @display.msg("req_letter")
    guess_letter(gets.chomp)
  end

  def guess_letter(letter)
    letter = letter.upcase

    return unless letter_valid?(letter) == true

    @guessed[letter.to_sym] = true
    @missed[letter.to_sym] = true unless @word.include?(letter)
    @display.show_clue(@guessed, @missed)
  end

  def letter_valid?(letter)
    if @guessed[letter.to_sym] || @missed[letter.to_sym]
      @display.msg("guessed")
      return false
    elsif letter.match(/[^A-Z]/)
      @display.msg("invalid")
      return false
    end
    true
  end
end
