# frozen_string_literal: true

require 'rspec'
require 'pty'
require 'byebug'
require_relative 'spec_constants'
require_relative '../modules/board'
require_relative '../modules/colorize'
require_relative '../modules/interface'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end
