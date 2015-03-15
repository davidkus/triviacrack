require "time"

require "triviacrack/game"
require "triviacrack/parsers/constants"
require "triviacrack/parsers/game_statistics_parser"
require "triviacrack/parsers/question_parser"
require "triviacrack/parsers/user_parser"

# Internal: This module is used to parse data returned from the Trivia Crack API
# into a ruby object that represents a Trivia Crack game.
module TriviaCrack
  module Parsers
    module GameParser

      include TriviaCrack::Parsers::Constants

      # Internal: Parses data returned from the Trivia Crack API to create a
      # TriviaCrack::Game object.
      #
      # raw_data - A hash of the raw data returned by the Trivia Crack API.
      #
      # Examples
      #
      #   raw_data = get_raw_data_from_API
      #   ...
      #   game = TriviaCrack::Parsers::GameParser.parse raw_data
      #
      # Returns a TriviaCrack::Game.
      def self.parse(raw_data)
        questions = []
        if raw_data["spins_data"]
          raw_data["spins_data"]["spins"][0]["questions"].each do |q_data|
            q_data = q_data["question"]
            q_data["type"] = raw_data["spins_data"]["spins"][0]["type"]
            question = TriviaCrack::Parsers::QuestionParser.parse q_data
            questions << question
          end
        end

        if raw_data["available_crowns"]
          crowns = raw_data["available_crowns"].map { |c| c.downcase.to_sym }
        else
          crowns = []
        end

        if raw_data["my_player_number"] == 1
          my_player = "player_one"
          opponent_player = "player_two"
        else
          my_player = "player_two"
          opponent_player = "player_one"
        end

        opponent = TriviaCrack::Parsers::UserParser.parse raw_data["opponent"]

        my_statistics_raw = raw_data["statistics"]["#{my_player}_statistics"]
        my_statistics_raw["crowns"] = raw_data[my_player]["crowns"]

        opponent_statistics_raw =
          raw_data["statistics"]["#{opponent_player}_statistics"]

        opponent_statistics_raw["crowns"] = raw_data[opponent_player]["crowns"]

        my_statistics = GameStatisticsParser.parse my_statistics_raw
        opponent_statistics = GameStatisticsParser.parse opponent_statistics_raw

        TriviaCrack::Game.new(
          id: raw_data["id"],
          opponent: opponent,
          game_status: raw_data["game_status"].downcase.to_sym,
          language: raw_data["language"].downcase.to_sym,
          created: Time.strptime(raw_data["created"], TIME_FORMAT),
          last_turn: Time.strptime(raw_data["last_turn"], TIME_FORMAT),
          type: raw_data["type"].downcase.to_sym,
          expiration_date: Time.strptime(raw_data["expiration_date"],
                                         TIME_FORMAT),
          my_turn: raw_data["my_turn"],
          round_number: raw_data["round_number"],
          is_random: raw_data["is_random"],
          unread_messages: raw_data["unread_messages"],
          status_version: raw_data["status_version"],
          available_crowns: crowns,
          questions: questions,
          my_statistics: my_statistics,
          opponent_statistics: opponent_statistics
        )
      end

    end
  end
end
