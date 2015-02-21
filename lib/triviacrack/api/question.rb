require "unirest"

require "triviacrack/api/constants"
require "triviacrack/errors/request_error"
require "triviacrack/parsers/game_parser"

# Public: All methods in this module make requests to the Trivia Crack answers
# API.
module TriviaCrack
  module API
    module Question

      include TriviaCrack::API::Constants

      # Public: Uses the Trivia Crack API to answer the given question.
      #
      # game      - The ID of the TriviaCrack::Game.
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
        response = Unirest.post(
          "#{API_HOST}/api/users/#{@user_id}/games/#{game_id}/answers",
          parameters: { type: question.type,
            answers: [{ id: question.id,
              answer: answer,
              category: question.category
              }]
            }.to_json)

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code)
        end

        game = TriviaCrack::Parsers::GameParser.parse response.body

        [game, answer == question.correct_answer]
      end

    end
  end
end
