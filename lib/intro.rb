require_relative "display"
require_relative "game"
require "yaml"

# Determines if we start a new game or continue a save
class Intro
  include Display

  def start_hangman
    Dir.mkdir("saves") unless Dir.exist?("./saves")
    introduction

    case new_or_load
    when "new" then start_new_game
    when "load" then load_game
    end
  end

  private

  def new_or_load
    return "new" if Dir.empty?("./saves")

    message("new_game")

    input = ""
    until input.length == 1 && input.match?(/[1,2]/)
      input = gets.chomp
      message("new_game") if input.length != 1 || !input.match?(/[1,2]/)
    end

    return "new" if input == "1"
    return "load" if input == "2" # rubocop:disable Style/RedundantReturn
  end

  def load_game
    save_num = choose_save
    obj = from_yaml(save_num)
    File.delete("./saves/save#{save_num}")

    game = Game.new(obj[:word], obj[:guessed], obj[:missed])
    message("loaded")
    game.start_playing
  end

  def choose_save
    arr = Dir.children("./saves").map { |name| name[4, name.length] }
    message("saves_avail", arr.sort.join(", "))

    message("load_save_num")
    save_num = gets.chomp
    return save_num if arr.include?(save_num)

    until arr.include?(save_num)
      message("invalid_code")
      save_num = gets.chomp
    end
    save_num
  end

  def from_yaml(save_num)
    save = File.open("./saves/save#{save_num}")

    yaml_string = ""
    File.readlines(save).each do |line|
      yaml_string += line
    end

    YAML.load(yaml_string) # rubocop:disable Security/YAMLLoad
  end

  def start_new_game
    game = Game.new
    game.start_playing
  end
end
