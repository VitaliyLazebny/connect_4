# frozen_string_literal: true
require_relative 'spec_helper'

describe Colorize do
  it 'red' do
    expect(Colorize.red('red')).to eq "\e[31mred\e[0m"
  end

  it 'yellow' do
    expect(Colorize.yellow('yellow')).to eq "\e[33myellow\e[0m"
  end
end
