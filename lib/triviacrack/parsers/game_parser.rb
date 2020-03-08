require "triviacrack/game"
require "triviacrack/parsers/game_statistics_parser"
require "triviacrack/parsers/question_parser"
require "triviacrack/parsers/time_parser"
require "triviacrack/parsers/user_parser"

# Internal: This module is used to parse data returned from the Trivia Crack API
# into a ruby object that represents a Trivia Crack game.
module TriviaCrack
  module Parsers
    module GameParser

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
          if raw_data["spins_data"]["spins"][0]["type"] == "DUEL"
            q_data = raw_data["spins_data"]["spins"][0]["tie_break_question"]
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

        me = raw_data["my_player_number"] == 1 ? "player_one" : "player_two"
        them = raw_data["my_player_number"] == 1 ? "player_two" : "player_one"

        my_statistics = raw_data["statistics"]["#{me}_statistics"]
        my_statistics["crowns"] = raw_data[me]["crowns"]

        opponent_statistics = raw_data["statistics"]["#{them}_statistics"]
        opponent_statistics["crowns"] = raw_data[them]["crowns"]

        TriviaCrack::Game.new(
          id: raw_data["id"],
          opponent: UserParser.parse(raw_data["opponent"]),
          game_status: raw_data["game_status"].downcase.to_sym,
          language: raw_data["language"].downcase.to_sym,
          created: TimeParser.parse(raw_data["created"]),
          last_turn: TimeParser.parse(raw_data["last_turn"]),
          type: raw_data["type"].downcase.to_sym,
          expiration_date: TimeParser.parse(raw_data["expiration_date"]),
          my_turn: raw_data["my_turn"],
          round_number: raw_data["round_number"],
          is_random: raw_data["is_random"],
          unread_messages: raw_data["unread_messages"],
          status_version: raw_data["status_version"],
          available_crowns: crowns,
          questions: questions,
          my_statistics: GameStatisticsParser.parse(my_statistics),
          opponent_statistics: GameStatisticsParser.parse(opponent_statistics)
        )
      end

    end
  end
end
