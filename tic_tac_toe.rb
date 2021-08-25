class Player
  attr_reader :symbol
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Board
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @grid = [' ', ' ', ' ',
             ' ', ' ', ' ', 
             ' ', ' ', ' ']
  end

  def display
    puts "#{@grid[0]} | #{@grid[1]} | #{@grid[2]}"
    puts "---------"
    puts "#{@grid[3]} | #{@grid[4]} | #{@grid[5]}"
    puts "---------"
    puts "#{@grid[6]} | #{@grid[7]} | #{@grid[8]}"
  end
end

game = Board.new('Marco', 'Aaron')
game.display