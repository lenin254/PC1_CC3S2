class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError unless letter =~ /^[a-zA-Z]$/

    letter.downcase!

    if @word.include?(letter) && !@guesses.include?(letter)
      @guesses << letter
      return true
    elsif !@word.include?(letter) && !@wrong_guesses.include?(letter)
      @wrong_guesses << letter
      return true
    else
      return false
    end
  end

  def word_with_guesses
    display_word = ''
    word.chars do |letter|
      if guesses.include?(letter)
        display_word << letter
      else
        display_word << '-'
      end
    end
    display_word
  end

  def check_win_or_lose
    return :win if word_with_guesses == word
    return :lose if wrong_guesses.length >= 7
    :play
  end

  private

  def valid_guess?(letter)
    !letter.nil? && letter.match?(/^[a-zA-Z]$/)
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
