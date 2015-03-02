# Public: An object representing player statistics for a Trivia Crack game.
module TriviaCrack
  class GameStatistics

    # Public: The number of questions answered correctly.
    attr_reader :correct_answers

    # Public: The number of questions answered incorrectly.
    attr_reader :incorrect_answers

    # Public: The total number of questions answered.
    attr_reader :questions_answered

    # Public: The total number of challenges won.
    attr_reader :challenges_won

    # Public: The list of categories for which crowns have been won.
    attr_reader :crowns

    # Public: A hash of category statistics.
    attr_reader :categories

    def initialize(correct_answers: nil, incorrect_answers: nil,
                   questions_answered: nil, challenges_won: nil,
                   crowns: nil, categories: nil)
      @correct_answers    = correct_answers
      @incorrect_answers  = incorrect_answers
      @questions_answered = questions_answered
      @challenges_won     = challenges_won
      @crowns             = crowns
      @categories         = categories
    end

  end
end
