# frozen_string_literal: true

# Instructions
# Simple 3x3 grid
# Two human players
# Announce Win or lose or draw

# This module will be used in result checking
module Result
  WIN_PATTERNS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

  def win1?
    win = WIN_PATTERNS.each do |pattern|
      if (@grid[pattern[0]] == @p1.symbol) && (@grid[pattern[1]] == @p1.symbol) && (@grid[pattern[2]] == @p1.symbol)
        return true
      end
    end
    false
  end

  def win2?
    win = WIN_PATTERNS.each do |pattern|
      if (@grid[pattern[0]] == @p2.symbol) && (@grid[pattern[1]] == @p2.symbol) && (@grid[pattern[2]] == @p2.symbol)
        return true
      end
    end
    false
  end

  def draw?
    true if @turn == 8
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

# This board operates all the things happening underneath and 'mixin' with Result module to check result
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
    puts '--+---+--'
    puts "#{@grid[3]} | #{@grid[4]} | #{@grid[5]}"
    puts '--+---+--'
    puts "#{@grid[6]} | #{@grid[7]} | #{@grid[8]}"
    puts ''
  end

  def play
    until win1? || win2? || draw?
      puts 'Cell: '
      cell = gets.chomp.to_i - 1
      puts ''

      unless valid_input?(cell)
        puts 'Invalid input!'
        next
      end

      @grid[cell] = switch
      display
    end
    final_result
  end

  private

  def valid_input?(input)
    return false if !input.between?(0, 8) || (@grid[input] == @p1.symbol) || (@grid[input] == @p2.symbol)

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
    elsif draw?
      puts 'Draw!'
    end
  end
end

def tic_tac_toe
  puts "Welcome! This is Tic-Tac-Toe PvP. Rules are simple.\n
If you can get your three symbols in consecutive order(x-axis or y-axis or diagonally), you win!\n
Here's the cells positions."

  puts '1 | 2 | 3'
  puts '--+---+--'
  puts '4 | 5 | 6'
  puts '--+---+--'
  puts '7 | 8 | 9'
  puts ''

  puts 'Enter player 1 name: '
  p1_name = gets.chomp.to_s
  puts 'Enter player 1 symbol: '
  p1_symbol = gets.chomp.to_s

  puts 'Enter player 2 name: '
  p2_name = gets.chomp.to_s
  puts 'Enter player 2 symbol: '
  p2_symbol = gets.chomp.to_s

  p1 = Player.new(p1_name, p1_symbol)
  p2 = Player.new(p2_name, p2_symbol)
  game = Board.new(p1, p2)
  game.display
  game.play
end

tic_tac_toe
