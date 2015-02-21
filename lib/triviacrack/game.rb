# Public: An object representing a Trivia Crack Game, including information
# about the questions to be asked in the game, the state of the game, opponent
# information, and more.
module TriviaCrack
  class Game

    attr_reader :id, :opponent, :game_status, :language, :created, :last_turn,
                :type, :expiration_date, :my_turn, :round_number, :sub_status,
                :prev_sub_status, :is_random, :unread_messages,
                :status_version, :available_crowns, :questions

    def initialize(id:, opponent: nil, game_status: nil, language: nil,
                   created: nil, last_turn: nil, type: nil,
                   expiration_date: nil, my_turn: nil, round_number: nil,
                   sub_status: nil, prev_sub_status: nil, is_random: nil,
                   unread_messages: nil, status_version: nil,
                   available_crowns: nil, questions: nil)
      @id               = id
      @opponent         = opponent
      @game_status      = game_status
      @language         = language
      @created          = created
      @last_turn        = last_turn
      @type             = type
      @expiration_date  = expiration_date
      @my_turn          = my_turn
      @round_number     = round_number
      @sub_status       = sub_status
      @prev_sub_status  = prev_sub_status
      @is_random        = is_random
      @unread_messages  = unread_messages
      @status_version   = status_version
      @available_crowns = available_crowns
      @questions        = questions
    end

    # Public: Returns true if the game has not ended and it is the user's turn.
    #
    # Examples
    #
    #   if game.playable?
    #     ... do something ...
    #   end
    #
    # Returns a boolean indicating if the game is playable.
    def playable?
      @my_turn && @game_status != "ENDED"
    end

  end
end
