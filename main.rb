# frozen_string_literal: true

require_relative 'modules/board'
require_relative 'modules/interface'
require_relative 'modules/colorize'

board = Board.new
interface = Interface.new(board)
interface.start_game
