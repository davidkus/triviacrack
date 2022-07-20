# frozen_string_literal: true

require 'json'
require 'triviacrack/api/common'
require 'triviacrack/parsers/game_parser'

# Public: All methods in this module make requests to the Trivia Crack answers
# API.
module TriviaCrack
  module API
    module Question
      include TriviaCrack::API::Common

      # Public: Uses the Trivia Crack API to answer the given question.
      #
      # game_id   - The ID of the TriviaCrack::Game.
      # question  - The TriviaCrack::Question.
      # answer    - The index of the answer to be submitted.
      #
      # Examples
      #
      #   answer_question game.id, question, 1
      #
      # Returns a boolean indicating whether or not the question was answered
      # correctly, and the updated TriviaCrack::Game object.
      # Raises TriviaCrack::Errors::RequestError if the request fails
      def answer_question(game_id, question, answer)
        response =
          post "/api/users/#{@session.user_id}/games/#{game_id}/answers",
               parameters: { type: question.type.upcase,
                             answers: [{
                               id: question.id,
                               answer: answer,
                               category: question.category.upcase
                             }] }.to_json

        game = TriviaCrack::Parsers::GameParser.parse response

        [game, answer == question.correct_answer]
      end

      # Public: Uses the Trivia Crack API to answer duel questions for the game.
      #
      # game_id    - The ID of the TriviaCrack::Game.
      # questions  - The array of TriviaCrack::Question to answer
      # answer_map - Hash of question ID / answer indices.
      #
      # Examples
      #
      #   answers = {}
      #   for question in game.questions do
      #     answers[question.id] = <some answer index> // 0, 1, 2 or 3
      #   end
      #   answer_questions game.id, game.questions, answers
      #
      # Returns the update TriviaCrack::Game object, as well as a map
      # with an entry for each question ID and a boolean indicating if
      # the question was answered successfully.
      # Raises TriviaCrack::Errors::RequestError if the request fails
      def answer_questions(game_id, questions, answer_map) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        answers = []
        correct_answers = {}

        questions.each do |question|
          answer = {
            id: question.id,
            answer: answer_map[question.id],
            category: question.category.upcase
          }
          answers << answer
          correct_answers[question.id] = answer_map[question.id] == question.correct_answer
        end

        response =
          post "/api/users/#{@session.user_id}/games/#{game_id}/answers",
               parameters: { type: questions.first.type.upcase, answers: answers }.to_json

        game = TriviaCrack::Parsers::GameParser.parse response

        [game, correct_answers]
      end
    end
  end
end
