require "triviacrack/question"

# Internal: This module is used to parse data returned from the Trivia Crack API
# into a ruby object that represents a Trivia Crack question.
module TriviaCrack
  module Parsers
    module QuestionParser

      # Internal: Parses data returned from the Trivia Crack API to create a
      # TriviaCrack::Question object.
      #
      # raw_data  - A hash of the raw data returned by the Trivia Crack API.
      #
      # Examples
      #
      #   raw_data = get_raw_data_from_API
      #   ...
      #   question = TriviaCrack::Parsers::QuestionParser.parse raw_data
      #
      # Returns a TriviaCrack::Question.
      def self.parse(raw_data)
        TriviaCrack::Question.new id: raw_data["id"],
                                  type: raw_data["type"],
                                  category: raw_data["category"],
                                  text: raw_data["text"],
                                  answers: raw_data["answers"],
                                  correct_answer: raw_data["correct_answer"],
                                  media_type: raw_data["media_type"]
      end

    end
  end
end
