module Result
  WIN_PATTERNS = [[0,1,2], [0,3,6], [0,4,8]]

  def win?
  end
end

class Player
  attr_reader :symbol
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Board
  include Result
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @grid = [' ', ' ', ' ',
             ' ', ' ', ' ', 
             ' ', ' ', ' ']
    @turn = -1
  end

  def display
    puts "#{@grid[0]} | #{@grid[1]} | #{@grid[2]}"
    puts "---------"
    puts "#{@grid[3]} | #{@grid[4]} | #{@grid[5]}"
    puts "---------"
    puts "#{@grid[6]} | #{@grid[7]} | #{@grid[8]}"
  end

  def play
    until win? # or draw?
      puts "Cell: "
      cell = gets.chomp.to_i
      @grid[cell-1] = self.switch
      self.display
    end
  end

  private

  def switch
    @turn += 1
    @turn.even? ? @p1.symbol : @p2.symbol
  end
end

p1 = Player.new('Marco', 'X')
p2 = Player.new('Aaron', 'O')
game = Board.new(p1, p2)
game.display
game.play