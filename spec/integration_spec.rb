# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Integration' do
  before(:each) do
    @output, @input = PTY.spawn('ruby main.rb')
  end

  it 'red win' do
    3.times do
      @input.puts('1') # red move
      @input.puts('2') # yellow move
    end

    @input.puts('1') # red should win

    sleep 1 # wait when application will finish output
    console_log = @output.readpartial(10_000)
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

    sleep 1 # wait when application will finish output
    console_log = @output.readpartial(10_000)
    expect(console_log).to include('Player yellow won!')
    expect(console_log).to include('Bye!')
  end

  it 'exit using -1 command' do
    @input.puts('-1') # exit the game

    sleep 1 # wait when application will finish output
    console_log = @output.readpartial(10_000)
    expect(console_log).to include('Bye!')
  end
end
