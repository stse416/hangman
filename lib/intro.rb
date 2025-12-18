require_relative "display"
require_relative "game"

# Determines if we start a new game or continue a save
class Intro
  include Display

  def start_Hangman
    introduction
    return unless new_or_save == "new"

    start_new_game
  end

  def new_or_save
    message("new_game")

    input = ""
    until input.length == 1 && input.match?(/[1,2]/)
      input = gets.chomp
      message("new_game") if input.length != 1 || !input.match?(/[1,2]/)
    end

    load_game if input == "2"
    "new" if input == "1"
  end

  def load_game
    "a"
  end

  def start_new_game
    game = Game.new
    game.start_playing
  end
end
