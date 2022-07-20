# frozen_string_literal: true

require 'triviacrack/category_statistics'

# Internal: This module is used to parse data returned from the Trivia Crack API
# into a ruby object that represents category statistics for a Trivia Crack
# game.
module TriviaCrack
  module Parsers
    module CategoryStatisticsParser
      # Internal: Parses data returned from the Trivia Crack API to create
      # TriviaCrack::CategoryStatistics objects.
      #
      # raw_data - A hash of the raw data returned by the Trivia Crack API.
      #
      # Examples
      #
      #   raw_data = get_raw_data_from_API
      #   ...
      #   stats = TriviaCrack::Parsers::CategoryStatisticsParser.parse raw_data
      #
      # Returns a hash of TriviaCrack::CategoryStatistics objects, keyed by
      # category.
      def self.parse(raw_data) # rubocop:disable Metrics/MethodLength
        categories = {}

        raw_data&.each do |category|
          category_name = category['category'].downcase.to_sym

          categories[category_name] =
            TriviaCrack::CategoryStatistics.new(
              category: category_name,
              correct: category['correct'],
              incorrect: category['incorrect'],
              worst: category['worst']
            )
        end

        categories
      end
    end
  end
end
