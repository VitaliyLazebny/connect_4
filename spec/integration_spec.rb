# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Integration' do
  def read_output
    data = ''

    begin
      @output.each { |line| data += line }
    rescue Errno::EIO, EOFError
    end

    data
  end

  before(:each) do
    @output, @input = PTY.spawn('ruby main.rb')
  end

  it 'red win' do
    3.times do
      @input.puts('1') # red move
      @input.puts('2') # yellow move
    end

    @input.puts('1') # red should win

    console_log = read_output
    expect(console_log).to include('Player red won!')
    expect(console_log).to include('Bye!')
  end

  it 'yellow win' do
    3.times do
      @input.puts('1') # red move
      @input.puts('2') # yellow move
    end

    @input.puts('0') # red are missing
    @input.puts('2') # yellow should win

    console_log = read_output
    expect(console_log).to include('Player yellow won!')
    expect(console_log).to include('Bye!')
  end

  it 'exit using -1 command' do
    @input.puts('-1') # exit the game

    console_log = read_output
    expect(console_log).to include('Bye!')
  end
end
