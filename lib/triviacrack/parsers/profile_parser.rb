require "triviacrack/profile"
require "triviacrack/parsers/category_statistics_parser"
require "triviacrack/parsers/time_parser"

# Internal: This module is used to parse data returned from the Trivia Crack API
# into a ruby object that represents a Trivia Crack user profile.
module TriviaCrack
  module Parsers
    module ProfileParser

      # Internal: Parses data returned from the Trivia Crack API to create a
      # TriviaCrack::Profile object.
      #
      # raw_data - A hash of the raw data returned by the Trivia Crack API.
      #
      # Examples
      #
      #   raw_data = get_raw_data_from_API
      #   ...
      #   profile = TriviaCrack::Parsers::ProfileParser.parse raw_data
      #
      # Returns a TriviaCrack::Profile.
      def self.parse(raw_data)
        stats = raw_data["statistics"]
        versus = raw_data["versus"]

        categories = CategoryStatisticsParser.parse stats["category_questions"]

        TriviaCrack::Profile.new(
          id: raw_data["id"],
          facebook_name: raw_data["facebook_name"],
          is_friend: raw_data["is_friend"],
          is_blocked: raw_data["is_blocked"],
          username: raw_data["username"],
          country: raw_data["country"].downcase.to_sym,
          email: raw_data["email"],
          last_play: TimeParser.parse(raw_data["last_play_date"]),
          last_login: TimeParser.parse(raw_data["last_log"]),
          games_won: stats["games_won"],
          games_lost: stats["games_lost"],
          games_resigned: stats["games_resigned"],
          consecutive_games_won: stats["consecutive_games_won"],
          consecutive_answers_correct: stats["consecutive_answers_correct"],
          level: raw_data["level_data"]["level"],
          challenges_won: stats["challenges"]["won"],
          challenges_lost: stats["challenges"]["lost"],
          categories: categories,
          my_wins_vs_user: versus ? versus["won"] : nil,
          my_losses_vs_user: versus ? versus["lost"] : nil
        )
      end

    end
  end
end
