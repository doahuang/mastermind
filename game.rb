require_relative "code"

class Game
  def initialize
    @secret_code = Code.random
    @log = {}
  end
  def render
    intro
    show_log
  end
  def play
    10.times do
      render
      code = get_guess
      handle_guess(code)
      break if code == @secret_code
    end
    render
    game_over
  end
  private
  def intro
    system("clear") || system("cls")
    puts "let's play mastermind!"
    puts
  end
  def get_guess
    puts @secret_code.colors
    print "make a guess: "
    @secret_code.class.parse(gets.chomp)
  end
  def show_log
    return if @log.empty?
    @log.each do |guess, result|
      puts " " + guess.join + " => " + result
    end
    puts
  end
  def invalid?(code)
    code.pegs.empty? || code.pegs.size > 4
  end
  def handle_guess(code)
    return if invalid?(code)
    exact, near = code.show_matches(@secret_code)
    @log[code.pegs] = "A" * exact + "B" * near
  end
  def game_over
    code = @secret_code.pegs.join
    puts "game over, the code is \"#{code}\"!"
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end