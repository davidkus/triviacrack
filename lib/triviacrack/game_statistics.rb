# Public: An object representing player statistics for a Trivia Crack game.
module TriviaCrack
  class GameStatistics

    attr_reader :correct_answers, :incorrect_answers, :questions_answered,
                :challenges_won, :crowns_won, :categories

    def initialize(correct_answers: nil, incorrect_answers: nil,
                   questions_answered: nil, challenges_won: nil,
                   crowns_won: nil, categories: nil)
      @correct_answers    = correct_answers
      @incorrect_answers  = incorrect_answers
      @questions_answered = questions_answered
      @challenges_won     = challenges_won
      @crowns_won         = crowns_won
      @categories         = categories
    end

  end
end
