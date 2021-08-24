class Board
  def initialize
    @squares = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end
  
  def display
    @squares.each do |square|
      print "\n" if square % 3 == 1
      print " #{square} |"
    end
  end

  def self.update(name, number)
    # TODO
  end

  def self.result
    # TODO
  end
end

class Player
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def play(choice)
    # TODO
  end
end

# Execute method is needed here
board = Board.new
board.display
print "\n"