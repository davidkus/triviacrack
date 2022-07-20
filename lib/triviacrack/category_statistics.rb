# frozen_string_literal: true

# Public: An object representing category statistics for a player within a
# single Trivia Crack game.
module TriviaCrack
  class CategoryStatistics
    # Public: The category for these statistics (:arts, :geography, etc).
    attr_reader :category

    # Public: The number of questions answered correctly for this category.
    attr_reader :correct

    # Public: The number of questions answered incorrectly for this category.
    attr_reader :incorrect

    # Public: Boolean indicating whether this is the worst category for the
    # player.
    attr_reader :worst

    def initialize(category: nil, correct: nil, incorrect: nil, worst: nil)
      @category  = category
      @correct   = correct
      @incorrect = incorrect
      @worst     = worst
    end
  end
end
