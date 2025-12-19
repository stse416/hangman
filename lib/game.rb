require_relative "dictionary"
require_relative "display"
require "yaml"

# Game logic handler
class Game
  def initialize(word = nil, guessed = {}, missed = {})
    @word = get_word(word)
    @guessed = guessed
    @missed = missed
    @game_over = false
  end

  include Display

  def start_playing
    show_clue(@word, @guessed, @missed)
    start_turn while !@game_over && @missed.size < 8
    return unless @missed.size >= 8

    message("lose", @word)
  end

  private

  def start_turn
    message("req_letter")

    input = gets.chomp
    return if save_check(input)

    guess_letter(input)
  end

  def save_check(input)
    return false unless input.match?(/save/i)

    save_game(create_save_location, to_yaml)
    @game_over = true
  end

  def guess_letter(letter)
    letter = letter.upcase

    return unless letter_valid?(letter) == true

    @guessed[letter.to_sym] = true if @word.include?(letter)
    @missed[letter.to_sym] = true unless @word.include?(letter)
    fully_guessed = show_clue(@word, @guessed, @missed)

    process_win if fully_guessed
  end

  def letter_valid?(letter)
    if @guessed[letter.to_sym] || @missed[letter.to_sym]
      message("guessed")
      show_clue(@word, @guessed, @missed)
      return false
    elsif letter.match(/[^A-Z]/) || letter.length > 1 || letter.empty?
      message("invalid")
      show_clue(@word, @guessed, @missed)
      return false
    end
    true
  end

  def get_word(word)
    return word if word

    Dictionary.new("google-10000-english-no-swears.txt").game_word.upcase
  end

  def process_win
    message("win")
    @game_over = true
  end

  def save_game(file, yaml_string)
    file.puts(yaml_string)
    file.close
  end

  def to_yaml
    YAML.dump({
                word: @word,
                guessed: @guessed,
                missed: @missed
              })
  end

  def create_save_location
    saved = false
    num = 1
    while saved == false
      exist = File.exist?("./saves/save#{num}")
      unless exist
        f = File.new("./saves/save#{num}", "w")
        message("saved", num)
        saved = true
      end

      num += 1
    end
    f
  end
end
