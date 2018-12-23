# frozen_string_literal: true
require_relative 'spec_helper'

describe Interface do
  before(:each) do
    allow(Colorize).to receive(:yellow) { 'y' }
    allow(Colorize).to receive(:red) { 'r' }
    allow(Colorize).to receive(:send) { 'send' }
    allow_any_instance_of(Board)
      .to receive(:field) do
      Array.new(6) { [:red, :yellow, :yellow, :yellow, :yellow, nil, nil] }
    end
    allow_any_instance_of(Board).to receive(:make_move) { true }
    allow_any_instance_of(Board).to receive(:connected_4?) { true }
  end

  let(:board) { Board.new }
  let(:interface) { Interface.new(board) }

  it 'can be initialized' do
    expect { interface }.not_to raise_error
  end

  it 'stop game exits the game' do
    expect do
      interface.stop_game
    end.to raise_error(SystemExit).and output("Bye!\n").to_stdout
  end

  it 'can show the board' do
    expect do
      interface.show_board
    end.to output("ryyyyoo\nryyyyoo\nryyyyoo\nryyyyoo\n"\
                   "ryyyyoo\nryyyyoo\n0123456\n").to_stdout
  end

  it 'can award winner' do
    expect do
      interface.award_winner
    end.to output("send\n").to_stdout
  end

  it 'can greet the winner' do
    expect do
      interface.greetings
    end.to output("Welcome at Connect Four game!\n"\
    'A two-player connection game in which the players first'\
    ' choose a color and then take turns dropping one colored'\
    ' disc from the top into a seven-column, six-row vertically'\
    ' suspended grid. The piecesfall straight down, occupying'\
    ' the lowest available space within the column. The objective'\
    ' of the game is to be the first to form a horizontal, '\
    "vertical, or diagonal line of four of one's own discs.\n"\
    "send\n").to_stdout
  end

  it 'can start game' do
    expect do
      interface.start_game
    end.to raise_error(SystemExit)
      .and output("Welcome at Connect Four game!\n"\
    'A two-player connection game in which the players first'\
    ' choose a color and then take turns dropping one colored'\
    ' disc from the top into a seven-column, six-row vertically'\
    ' suspended grid. The piecesfall straight down, occupying'\
    ' the lowest available space within the column. The objective'\
    ' of the game is to be the first to form a horizontal, vertical,'\
    " or diagonal line of four of one's own discs.\nsend\n"\
    "ryyyyoo\nryyyyoo\nryyyyoo\nryyyyoo\nryyyyoo\nryyyyoo\n"\
    "0123456\nsend\nBye!\n").to_stdout
  end

  it 'can start game and play at least one round' do
    allow_any_instance_of(Board)
      .to receive(:connected_4?)
      .and_return(false, true)
    allow(interface).to receive(:gets).and_return('3')

    expect do
      interface.start_game
    end.to raise_error(SystemExit)
      .and output(/Welcome at Connect Four game!/)
      .to_stdout
  end

  it 'can choose column' do
    allow(interface).to receive(:puts)
    allow(interface).to receive(:gets).and_return('3')
    expect(interface.choose_column).to eq(3)
  end

  it 'can try to choose invalid column' do
    allow(interface).to receive(:stop_game)
    allow(interface).to receive(:puts)
    allow(interface).to receive(:gets).and_return('-1', '1')
    expect(interface.choose_column).to eq(1)
  end

  it 'can try to choose invalid column and then correct one' do
    allow(interface).to receive(:puts)
    allow(interface).to receive(:gets).and_return('100', '1')
    expect(interface.choose_column).to eq 1
  end

  it 'by default player is red' do
    expect(interface.instance_variable_get(:@current_player)).to eq :yellow
  end

  it 'can change the player' do
    interface.change_player
    expect(interface.instance_variable_get(:@current_player)).to eq :red
  end
end
