require "time"

require "triviacrack/profile"
require "triviacrack/parsers/category_statistics_parser"
require "triviacrack/parsers/constants"

# Internal: This module is used to parse data returned from the Trivia Crack API
# into a ruby object that represents a Trivia Crack user profile.
module TriviaCrack
  module Parsers
    module ProfileParser

      include TriviaCrack::Parsers::Constants

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

        categories = {}
        if stats["category_questions"]
          stats["category_questions"].each do |category|
            categories[category["category"].downcase.to_sym] =
              TriviaCrack::Parsers::CategoryStatisticsParser.parse category
          end
        end

        TriviaCrack::Profile.new(
          id: raw_data["id"],
          facebook_name: raw_data["facebook_name"],
          is_friend: raw_data["is_friend"],
          is_blocked: raw_data["is_blocked"],
          username: raw_data["username"],
          country: raw_data["country"].downcase.to_sym,
          email: raw_data["email"],
          last_play: Time.strptime(raw_data["last_play_date"], TIME_FORMAT),
          last_login: Time.strptime(raw_data["last_log"], TIME_FORMAT),
          games_won: stats["games_won"],
          games_lost: stats["games_lost"],
          games_resigned: stats["games_resigned"],
          consecutive_games_won: stats["consecutive_games_won"],
          consecutive_answers_correct: stats["consecutive_answers_correct"],
          level: raw_data["level_data"]["level"],
          challenges_won: stats["challenges"]["won"],
          challenges_lost: stats["challenges"]["lost"],
          categories: categories,
          my_wins_vs_user: raw_data["versus"]["won"],
          my_losses_vs_user: raw_data["versus"]["lost"]
        )
      end

    end
  end
end
