class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(character)
    if character == nil or character.empty? or not ('a'..'z').include?(character.downcase)
      raise ArgumentError
    end

    if @guesses.include?(character.downcase) or @wrong_guesses.include?(character.downcase)
      return false
    elsif @word.include?(character.downcase)
      @guesses += character.downcase
    else
      @wrong_guesses += character.downcase
    end
    
    return true
  end

  def word_with_guesses()
    word_with_missing = ""

    @word.each_char do |char|
      if @guesses.include?(char)
        word_with_missing += char
      else
        word_with_missing += "-"
      end
    end
  
    return word_with_missing
  end

  def check_win_or_lose()
    if @guesses.length + @wrong_guesses.length >= 7
      return :lose
    elsif word_with_guesses() == @word
      return :win
    end

    return :play
  end
      
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
