require_relative "dictionary"
require_relative "display"
require "yaml"

# Game logic handler
class Game
  def initialize
    @dictionary = Dictionary.new("google-10000-english-no-swears.txt")
    @word = @dictionary.game_word.upcase
    @guessed = {}
    @missed = {}
    @game_over = false
  end

  include Display

  def start_playing
    start_turn while !@game_over && @missed.size < 8
    return unless @missed.size >= 8

    message("lose", @word)
  end

  private

  def start_turn
    message("req_letter")

    p "Word: #{@word}, Guessed: #{@guessed} Missed: #{@missed}"

    input = gets.chomp
    return if save_check(input)

    guess_letter(input)
  end

  def save_check(input)
    return false unless input.match?(/save/i)

    save_game(create_save_location)
    message("saved")
    @game_over = true
  end

  def guess_letter(letter)
    letter = letter.upcase

    return unless letter_valid?(letter) == true

    @guessed[letter.to_sym] = true if @word.include?(letter)
    # FOR TESTING
    p "Guessed: #{@guessed}, size is #{@guessed.size}. Word is #{@word}, length is #{@word.length}"
    @missed[letter.to_sym] = true unless @word.include?(letter)
    fully_guessed = show_clue(@word, @guessed, @missed)

    process_win if fully_guessed
  end

  def letter_valid?(letter)
    if @guessed[letter.to_sym] || @missed[letter.to_sym]
      message("guessed")
      return false
    elsif letter.match(/[^A-Z]/) || letter.length > 1 || letter.empty?
      message("invalid")
      return false
    end
    true
  end

  def process_win
    message("win")
    @game_over = true
  end

  def save_game(file)
    # serializes game to the file
  end

  def create_save_location
    saved = false
    num = 1
    while saved == false
      exist = File.exist?("./saves/save#{num}")
      unless exist
        f = File.new("./saves/save#{num}", "w")
        saved = true
      end

      num += 1
    end
    f
  end
end
