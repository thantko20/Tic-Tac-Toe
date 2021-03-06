# frozen_string_literal: true

# Instructions
# Simple 3x3 grid
# Two human players
# Announce Win or lose or draw

# This module will be used in result checking
module Result
  WIN_PATTERNS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

  def draw?
    if @turn == 9
      puts 'Draw!'
      return true
    end
    false
  end

  def game_over?(player)
    check_row(player) || draw?
  end

  def check_row(player)
    WIN_PATTERNS.each do |pattern|
      if (@grid[pattern[0]] == player.symbol) && (@grid[pattern[1]] == player.symbol) && (@grid[pattern[2]] == player.symbol)
        puts "#{player.name} won!"
        return true
      end
    end
    false
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
    @turn = 0
  end

  def play
    loop do
      display
      curr_player = player_turn
      puts 'Cell: '
      cell = player_input
      @grid[cell] = curr_player.symbol
      break if game_over?(curr_player)
    end
    display
  end

  def player_input
    loop do
      input = gets.chomp.to_i - 1
      return input if verify_input(input)

      puts "Invalid input!\n\n"
    end
  end

  def verify_input(input)
    input.between?(0, 8) && (@grid[input] != @p1.symbol) && (@grid[input] != @p2.symbol)
  end

  def player_turn
    @turn += 1
    @turn.odd? ? @p1 : @p2
  end

  private

  def display
    puts "#{@grid[0]} | #{@grid[1]} | #{@grid[2]}"
    puts '--+---+--'
    puts "#{@grid[3]} | #{@grid[4]} | #{@grid[5]}"
    puts '--+---+--'
    puts "#{@grid[6]} | #{@grid[7]} | #{@grid[8]}"
    puts ''
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

  puts 'Enter player 2 name: '
  p2_name = gets.chomp.to_s

  p1 = Player.new(p1_name, 'X')
  p2 = Player.new(p2_name, 'O')
  game = Board.new(p1, p2)
  game.play
end

tic_tac_toe
