class Dictionary
  attr_reader :game_word

  def initialize(file)
    @words = get_array_of_words(file)
    @game_word = get_word(@words)
  end

  def get_array_of_words(file)
    f = File.open(file)
    words = []

    while (line = f.gets)
      words.push(line.chomp) if line.length.between?(5, 12)
    end

    words
  end

  def get_word(arr)
    arr[rand(arr.length - 1)]
  end
end

words = Dictionary.new("google-10000-english-no-swears.txt")
p words.game_word
