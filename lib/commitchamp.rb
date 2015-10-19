require "httparty"
require "pry"

require "commitchamp/version"
require "commitchamp/github"
# Probably you also want to add a class for talking to github.

module Commitchamp
  class App
    def initialize
    end

    def run
      binding.pry
    end
  end
end

app = Commitchamp::App.new
app.run
