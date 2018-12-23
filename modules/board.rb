# frozen_string_literal: true

#
# Represent and contains all the discs
#
class Board
  HEIGHT = 6 # Y axe size
  WIDTH  = 7 # X axe size

  attr_reader :field

  def initialize
    @field = Array.new(HEIGHT) { Array.new(WIDTH) }
  end

  #
  # Function accepts column where will be saved sign.
  # Sign is uniq id of player.
  #
  # false return means column oveload
  # player should choose other column to
  # make a move.
  #
  def make_move(column, sign)
    (HEIGHT - 1).downto(0) do |h|
      unless @field[h][column]
        @field[h][column] = sign
        return true # move was successful
      end
    end

    false # move was not done
  end

  #
  # Check each point on the field if it is not
  # top of the winners line
  #
  def connected_4?
    (0..6).each do |y|
      (0..7).each do |x|
        return true if check_winner_for_point(x, y)
      end
    end

    false # no winner by default
  end

  private

  #
  # Winner is present when there's 4 elements in row
  # with the same data. (nil is absence of data,
  # so nil can't indicate presence of winner).
  #
  def check_winner_for_point(x_axis, y_axis)
    # Get rows where POSSIBLY can be same value used
    lines = get_lines_for_point(x_axis, y_axis)

    # Since all the lines are processed in same way
    # and collected in almost the same way they are
    # collected into lines array
    lines.each do |line|
      # first line element will be compared to others
      value = line.first
      # ignore nil elements
      return false unless value
      # check if all line elements are same
      return true if line.count(value) == 4
    end

    false # no winner by default
  end

  #
  # According each point i should get 4 lines 4 elements each:
  # 1. 4 elements up
  # 2. 4 elements right
  # 3. 4 elements right up diagonale
  # 4. 4 elements right down diagonale
  #
  # Return Array of 4 arrays with 4 characters each
  #
  # (1) (2)
  # x  x
  # x x
  # xx
  # xxxx (0)
  #  x
  #   x
  #    x (3)
  # --------
  # 1234
  #
  def get_lines_for_point(x_axis, y_axis)
    result = Array.new(4) { [] }

    (0..3).each do |i|
      # 4 elements right
      result[0] << field.dig(y_axis, x_axis + i)

      # 4 elements up
      result[1] << field.dig(y_axis + i, x_axis)

      # 4 elements to right up diagonale
      result[2] << field.dig(y_axis + i, x_axis + i)

      # 4 elements to right down diagonale
      result[3] << field.dig(y_axis - i, x_axis + i)
    end

    result
  end
end
