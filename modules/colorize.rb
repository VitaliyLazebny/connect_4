# frozen_string_literal: true

#
# Used to change text color
#
class Colorize
  def self.red(text)
    "\e[31m#{text}\e[0m"
  end

  def self.yellow(text)
    "\e[33m#{text}\e[0m"
  end
end
