# Public: An object representing a Trivia Crack Game, including information
# about the questions to be asked in the game, the state of the game, opponent
# information, and more.
module TriviaCrack
  class Game

    # Public: The unique identifier of the game.
    attr_reader :id

    # Public: The TriviaCrack::User information for the opponent.
    attr_reader :opponent

    # Public: The current status of the game (e.g. :active, :ended,
    # :pending_approval).
    attr_reader :game_status

    # Public: The language used for the game (e.g. :en).
    attr_reader :language

    # Public: The datetime on which the game was created.
    attr_reader :created

    # Public: The datetime on which the last turn was taken.
    attr_reader :last_turn

    # Public: The type of the game (:normal, :duel)
    attr_reader :type

    # Public: The datetime on which the game will expire.
    attr_reader :expiration_date

    # Public: Boolean indicating whether it is the user's turn.
    attr_reader :my_turn

    # Public: The number of the current round.
    attr_reader :round_number

    # Public: Boolean indicating whether the game was created with a random
    # opponent.
    attr_reader :is_random

    # Public: Number of unread messages.
    attr_reader :unread_messages

    # Public: The status version.
    attr_reader :status_version

    # Public: Array of available crowns that can be won by the user.
    attr_reader :available_crowns

    # Public: Array of questions that can be answered by the user. This array
    # will be empty if the user is unable to play (i.e. not their turn).
    attr_reader :questions

    # Public: TriviaCrack::GameStatistics for the user.
    attr_reader :my_statistics

    # Public: TriviaCrack::GameStatistics for the opponent.
    attr_reader :opponent_statistics

    def initialize(id:, opponent: nil, game_status: nil, language: nil,
                   created: nil, last_turn: nil, type: nil,
                   expiration_date: nil, my_turn: nil, round_number: nil,
                   is_random: nil, unread_messages: nil, status_version: nil,
                   available_crowns: nil, questions: nil, my_statistics: nil,
                   opponent_statistics: nil)
      @id                   = id
      @opponent             = opponent
      @game_status          = game_status
      @language             = language
      @created              = created
      @last_turn            = last_turn
      @type                 = type
      @expiration_date      = expiration_date
      @my_turn              = my_turn
      @round_number         = round_number
      @is_random            = is_random
      @unread_messages      = unread_messages
      @status_version       = status_version
      @available_crowns     = available_crowns
      @questions            = questions
      @my_statistics        = my_statistics
      @opponent_statistics  = opponent_statistics
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
      @my_turn && @game_status != :ended
    end

  end
end
