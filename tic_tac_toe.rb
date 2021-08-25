module Result
  def over?
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
  end

  def display
    puts "#{@grid[0]} | #{@grid[1]} | #{@grid[2]}"
    puts "---------"
    puts "#{@grid[3]} | #{@grid[4]} | #{@grid[5]}"
    puts "---------"
    puts "#{@grid[6]} | #{@grid[7]} | #{@grid[8]}"
  end

  def play
    until over?
      puts "Mark: "
      input = gets.chomp.to_s
      puts "Cell: "
      cell = gets.chomp.to_i
      @grid[cell-1] = input
      self.display
    end
  end
end

game = Board.new('Marco', 'Aaron')
game.display
game.play