# frozen_string_literal: true

require 'triviacrack/user'

# Internal: This module is used to parse data returned from the Trivia Crack API
# into a ruby object that represents a Trivia Crack user.
module TriviaCrack
  module Parsers
    module UserParser
      # Internal: Parses data returned from the Trivia Crack API to create a
      # TriviaCrack::User object.
      #
      # raw_data  - A hash of the raw data returned by the Trivia Crack API.
      #
      # Examples
      #
      #   raw_data = get_raw_data_from_API
      #   ...
      #   user = TriviaCrack::Parsers::UserParser.parse raw_data
      #
      # Returns a TriviaCrack::User.
      def self.parse(raw_data) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
        lives = raw_data['lives']
        level_data = raw_data['level_data']
        country = raw_data['country']

        TriviaCrack::User.new(
          id: raw_data['id'],
          username: raw_data['username'],
          facebook_id: raw_data['facebook_id'],
          facebook_name: raw_data['facebook_name'],
          coins: raw_data['coins'],
          lives: lives ? lives['quantity'] : nil,
          max_lives: lives ? lives['max'] : nil,
          unlimited_lives: lives ? lives['unlimited'] : nil,
          country: country ? country.downcase.to_sym : nil,
          extra_shots: raw_data['extra_shots'],
          level: level_data ? level_data['level'] : nil,
          level_points: level_data ? level_data['points'] : nil,
          level_progress: level_data ? level_data['progress'] : nil,
          goal_points: level_data ? level_data['goal_points'] : nil,
          level_up: level_data ? level_data['level_up'] : nil
        )
      end
    end
  end
end
