```ruby.rb
class WordGuesserGame
  # Esta es la definición de la clase WordGuesserGame.

  attr_accessor :word, :guesses, :wrong_guesses
  # Aquí se define el atributo de acceso para las variables de instancia word, guesses y wrong_guesses.
  # Esto permite obtener y establecer los valores de estas variables desde fuera de la clase.

  def initialize(word)
    # Este es el método constructor de la clase que se llama cuando se crea un nuevo objeto WordGuesserGame.
    # Toma un parámetro "word" que representa la palabra que el jugador debe adivinar.

    @word = word
    # Se asigna la palabra proporcionada al atributo de instancia @word.
    
    @guesses = ''
    @wrong_guesses = ''
    # Se inicializan los atributos de instancia @guesses y @wrong_guesses como cadenas vacías.
  end

  def guess(letter)
    # Este método se utiliza para hacer un intento de adivinar una letra de la palabra.

    raise ArgumentError unless letter =~ /^[a-zA-Z]$/
    # Se lanza una excepción ArgumentError si "letter" no es una letra del alfabeto (mayúscula o minúscula).

    letter.downcase!
    # Se convierte la letra ingresada a minúsculas para que el juego sea insensible a mayúsculas y minúsculas.

    if @word.include?(letter) && !@guesses.include?(letter)
      # Si la letra está en la palabra y no se ha adivinado antes:
      @guesses << letter
      # Se agrega la letra a la lista de adivinanzas correctas (@guesses).
      return true
    elsif !@word.include?(letter) && !@wrong_guesses.include?(letter)
      # Si la letra no está en la palabra y no se ha adivinado incorrectamente antes:
      @wrong_guesses << letter
      # Se agrega la letra a la lista de adivinanzas incorrectas (@wrong_guesses).
      return true
    else
      # En cualquier otro caso, el intento se considera incorrecto.
      return false
    end
  end

  def word_with_guesses
    # Este método genera una representación de la palabra a adivinar con letras adivinadas y guiones.

    display_word = ''
    word.chars do |letter|
      if guesses.include?(letter)
        # Si la letra está en la lista de adivinanzas correctas (@guesses), se muestra la letra.
        display_word << letter
      else
        # Si la letra no ha sido adivinada, se muestra un guión.
        display_word << '-'
      end
    end
    display_word
    # Retorna la representación de la palabra con letras adivinadas y guiones.
  end

  def check_win_or_lose
    # Este método verifica si el juego ha sido ganado, perdido o si aún está en juego.

    return :win if word_with_guesses == word
    # Si la palabra representada por las letras adivinadas coincide con la palabra original, el juego se considera ganado.

    return :lose if wrong_guesses.length >= 7
    # Si se han realizado 7 o más intentos incorrectos, el juego se considera perdido.

    :play
    # En cualquier otro caso, el juego está en curso.
  end

  private

  def valid_guess?(letter)
    # Este método verifica si una letra es una adivinanza válida (una sola letra del alfabeto).

    !letter.nil? && letter.match?(/^[a-zA-Z]$/)
    # Devuelve verdadero si "letter" no es nulo y es una letra del alfabeto (mayúscula o minúscula).
  end

  def self.get_random_word
    # Este es un método de clase que se utiliza para obtener una palabra aleatoria de un servicio remoto.

    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
    # Hace una solicitud HTTP al servicio remoto y devuelve la palabra aleatoria obtenida.
  end
end
```
