require 'pry-byebug'

module Result
  WIN_PATTERNS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
  # win_patterns = 
  def win1?
    win = WIN_PATTERNS.each do |pattern|
      if @grid[pattern[0]] == @p1.symbol and @grid[pattern[1]] == @p1.symbol and @grid[pattern[2]] == @p1.symbol
        return true
      end
    end
    false
  end

  def win2?
    win = WIN_PATTERNS.each do |pattern|
      if @grid[pattern[0]] == @p2.symbol and @grid[pattern[1]] == @p2.symbol and @grid[pattern[2]] == @p2.symbol
        return true
      end
    end
    false
  end

  def draw
    true if @turn > 8
  end
end

class Player
  attr_reader :name, :symbol
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
    @grid = [1, 2, 3,
             4, 5, 6, 
             7, 8, 9]
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
    until win1? or win2? or draw
      #binding.pry
      puts "Cell: "
      cell = gets.chomp.to_i - 1
      unless self.valid_input?(cell)
        puts "Invalid input!"
        next
      end
      @grid[cell] = self.switch
      self.display
    end
    self.final_result
  end

  private

  def valid_input?(input)
    if !input.between?(0, 8) or @grid[input] == @p1.symbol or @grid[input] == @p2.symbol
      return false
    end
    true
  end

  def switch
    @turn += 1
    @turn.even? ? @p1.symbol : @p2.symbol
  end

  def final_result
    if win1?
      puts "#{@p1.name} won!"
    elsif win2?
      puts "#{@p2.name} won!"
    else puts "Draw!" 
    end
  end
end

p1 = Player.new('Marco', 'X')
p2 = Player.new('Aaron', 'O')
game = Board.new(p1, p2)
game.display
game.play