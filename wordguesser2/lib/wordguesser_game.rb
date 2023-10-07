class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(char)
    if not /[a-z]/i.match?(char)
      raise ArgumentError
    end
    re = Regexp.new(char,"i")

    if re.match?(@word)
      if not re.match?(@guesses)
        @guesses.concat(char)
      else
        false
      end
    else
      if not re.match?(@wrong_guesses)
        @wrong_guesses.concat(char)
      else
        false
      end
      
    end
  end


  attr_accessor :word, :guesses, :wrong_guesses

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
