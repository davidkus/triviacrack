require "json"

require_relative "../lib/triviacrack/game"
require_relative "../lib/triviacrack/question"
require_relative "../lib/triviacrack/user"

require_relative "../lib/triviacrack/api/client"

require_relative "../lib/triviacrack/errors/parse_error"
require_relative "../lib/triviacrack/errors/request_error"

class SpecData

  def self.get(filename)
    file = File.read(File.expand_path("../data/#{filename}", __FILE__))
    JSON.parse(file)
  end

end
