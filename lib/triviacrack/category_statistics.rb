# Public: An object representing category statistics for a player within a
# single Trivia Crack game.
module TriviaCrack
  class CategoryStatistics

    attr_reader :category, :correct, :incorrect, :worst

    def initialize(category: nil, correct: nil, incorrect: nil, worst: nil)
      @category  = category
      @correct   = correct
      @incorrect = incorrect
      @worst     = worst
    end

  end
end
