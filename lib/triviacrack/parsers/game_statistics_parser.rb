require "triviacrack/game_statistics"
require "triviacrack/parsers/category_statistics_parser"

# Internal: This module is used to parse data returned from the Trivia Crack API
# into a ruby object that represents player statistics for a Trivia Crack game.
module TriviaCrack
  module Parsers
    module GameStatisticsParser

      # Internal: Parses data returned from the Trivia Crack API to create a
      # TriviaCrack::GameStatistics object.
      #
      # raw_data - A hash of the raw data returned by the Trivia Crack API.
      #
      # Examples
      #
      #   raw_data = get_raw_data_from_API
      #   ...
      #   stats = TriviaCrack::Parsers::GameStatisticsParser.parse raw_data
      #
      # Returns a TriviaCrack::GameStatistics.
      def self.parse(raw_data)
        categories =
          CategoryStatisticsParser.parse raw_data["category_questions"]

        if raw_data["crowns"]
          crowns = raw_data["crowns"].map { |c| c.downcase.to_sym }
        else
          crowns = []
        end

        TriviaCrack::GameStatistics.new(
          correct_answers: raw_data["correct_answers"],
          incorrect_answers: raw_data["incorrect_answers"],
          questions_answered: raw_data["questions_answered"],
          challenges_won: raw_data["challenges_won"],
          crowns: crowns,
          categories: categories
        )
      end

    end
  end
end
