# frozen_string_literal: true

#
# Just text interface.
# Duties: output information, get user input.
#
class Interface
  def initialize(board)
    @board          = board
    @players        = %i[red yellow]
    @current_player = :yellow
  end

  def start_game
    greetings

    until @board.connected_4?
      change_player
      show_board
      column = choose_column
      @board.make_move(column, @current_player)
    end

    show_board
    award_winner
    stop_game
  end

  #
  # Display board on the screen
  #
  def show_board
    # Double transpose is used to add next line
    # symbols since join automatically flatten
    # the array
    puts board.transpose.concat([Array.new(6) { "\n" }]).transpose.join('')

    # display column numbering
    puts '0123456'
  end

  #
  # Used at the beginning of game
  #
  def greetings
    puts 'Welcome at Connect Four game!'
    puts 'A two-player connection game in which the players first choose a '\
         'color and then take turns dropping one colored disc from the top '\
         'into a seven-column, six-row vertically suspended grid. The pieces'\
         'fall straight down, occupying the lowest available space within '\
         'the column. The objective of the game is to be the first to form '\
         'a horizontal, vertical, or diagonal line of four of one\'s own '\
         'discs.'
    puts Colorize.send(:red, 'First move is for Red player. '\
         'Right now board is empty.')
  end

  #
  # Show some congratulations to winner.
  #
  def award_winner
    puts Colorize.send(
      @current_player,
      "Player #{@current_player} won! Congratulations"
    )
  end

  # Replace virtual board signs with
  # color symbols that can be displayed
  # on screen.
  def board
    @board.field.map do |line|
      line.map do |character|
        case character
        when :red then Colorize.red('o')
        when :yellow then Colorize.yellow('o')
        else 'o'
        end
      end
    end
  end

  #
  # Ask user where he would like to make move.
  #
  def choose_column
    puts Colorize.send(@current_player, 'Please, choose column to place'\
      ' the disc. You can type -1 to exit game.')
    column = gets.chomp.to_i

    stop_game        if column == -1
    raise RangeError if column.negative? || column > 6

    column
  rescue RangeError
    puts Colorize.send(@current_player, 'Invalid column is choosen.')
    retry
  end

  #
  # Used after each successful move
  #
  def change_player
    @current_player = (@players - [@current_player]).first
  end

  #
  # Exit the game
  #
  def stop_game
    puts 'Bye!'
    exit
  end
end
