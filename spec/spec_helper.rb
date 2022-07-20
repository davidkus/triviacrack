# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'json'
require 'rspec/its'

require_relative '../lib/triviacrack/category_statistics'
require_relative '../lib/triviacrack/game'
require_relative '../lib/triviacrack/game_statistics'
require_relative '../lib/triviacrack/profile'
require_relative '../lib/triviacrack/question'
require_relative '../lib/triviacrack/session'
require_relative '../lib/triviacrack/user'

require_relative '../lib/triviacrack/api/client'
require_relative '../lib/triviacrack/api/game'
require_relative '../lib/triviacrack/api/login'
require_relative '../lib/triviacrack/api/profile'
require_relative '../lib/triviacrack/api/question'
require_relative '../lib/triviacrack/api/user'

require_relative '../lib/triviacrack/errors/parse_error'
require_relative '../lib/triviacrack/errors/request_error'

require_relative '../lib/triviacrack/parsers/category_statistics_parser'
require_relative '../lib/triviacrack/parsers/game_parser'
require_relative '../lib/triviacrack/parsers/game_statistics_parser'
require_relative '../lib/triviacrack/parsers/profile_parser'
require_relative '../lib/triviacrack/parsers/question_parser'
require_relative '../lib/triviacrack/parsers/session_parser'
require_relative '../lib/triviacrack/parsers/user_parser'

class SpecData
  def self.get(filename)
    File.read(File.expand_path("../data/#{filename}", __FILE__))
  end

  def self.get_json(filename)
    file = File.read(File.expand_path("../data/#{filename}", __FILE__))
    JSON.parse(file)
  end
end

class APIStub
  def initialize(session = nil)
    @session = session
  end
end
