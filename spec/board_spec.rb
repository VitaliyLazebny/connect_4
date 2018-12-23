# frozen_string_literal: true
require_relative 'spec_helper'

describe Board do
  let(:board) { Board.new }

  it 'can be initialized' do
    expect { board }.not_to raise_error
  end

  it 'initialized empty board' do
    field = board.field

    expect(field.size).to eq 6
    expect(field.first.size).to eq 7
    field.each { |row| expect(row.compact.size).to eq 0 }
  end

  it 'set marker on proper place' do
    board.make_move(2, 'X')
    expect(board.field[5][2]).to eq 'X'
  end

  it 'set marker over previous one' do
    2.times { board.make_move(2, 'X') }
    expect(board.field[4][2]).to eq 'X'
  end

  it 'when move was done correctly return true' do
    expect(board.make_move(2, 'X')).to eq true
  end

  it 'when column is overloaded and move can\'t be done returns false' do
    6.times { board.make_move(2, 'X') }

    expect(board.make_move(2, 'X')).to eq false
  end

  it 'find connected vertical' do
    allow_any_instance_of(Board).to receive(:field) do
      Constants::CONNECTED_VERTICAL
    end

    expect(board.connected_4?).to eq true
  end

  it 'find connected horizontal' do
    allow_any_instance_of(Board).to receive(:field) do
      Constants::CONNECTED_HORIZONTAL
    end

    expect(board.connected_4?).to eq true
  end

  it 'find connected right up diagonal' do
    allow_any_instance_of(Board).to receive(:field) do
      Constants::DIAGONALE_RIGHT_UP
    end

    expect(board.connected_4?).to eq true
  end

  it 'find connected right down diagonal' do
    allow_any_instance_of(Board).to receive(:field) do
      Constants::DIAGONALE_RIGHT_DOWN
    end

    expect(board.connected_4?).to eq true
  end

  it 'find connected right up diagonal with alternate sight' do
    allow_any_instance_of(Board).to receive(:field) do
      Constants::DIAGONALE_ALTERNATE_SIGN
    end

    expect(board.connected_4?).to eq true
  end

  it 'find connected four up at middle' do
    allow_any_instance_of(Board).to receive(:field) do
      Constants::CONNECTED_4_UP_RIGHT
    end

    expect(board.connected_4?).to eq true
  end

  it 'no 4 connected at the board' do
    allow_any_instance_of(Board).to receive(:field) do
      Constants::NO_4_CONNECTED
    end

    expect(board.connected_4?).to eq false
  end
end
