module TriviaCrack
  class Game
    attr_reader :id, :opponent, :game_status, :language, :created, :last_turn,
                :type, :expiration_date, :my_turn, :round_number, :sub_status,
                :previous_sub_status, :is_random, :unread_messages,
                :status_version, :available_crowns, :questions

    def initialize(id: 0, opponent: nil, game_status: nil, language: nil,
                   created: nil, last_turn: nil, type: nil,
                   expiration_date: nil, my_turn: nil, round_number: nil,
                   sub_status: nil, previous_sub_status: nil, is_random: nil,
                   unread_messages: nil, status_version: nil,
                   available_crowns: nil, questions: nil)
      @id = id
      @opponent = opponent
      @game_status = game_status
      @language = language
      @created = created
      @last_turn = last_turn
      @type = type
      @expiration_date = expiration_date
      @my_turn = my_turn
      @round_number = round_number
      @sub_status = sub_status
      @previous_sub_status = previous_sub_status
      @is_random = is_random
      @unread_messages = unread_messages
      @status_version = status_version
      @available_crowns = available_crowns
      @questions = questions
    end

    # Public: Returns true if the status of the game is 'ACTIVE' or
    # 'PENDING_APPROVAL' and it is also your turn.
    #
    # Examples
    #
    #   if game.playable?
    #     ... do something ...
    #   end
    #
    # Returns a boolean indicating if the game is playable.
    def playable?
      @my_turn && (@game_status == "ACTIVE" || @game_status == "PENDING_APPROVAL")
    end

    # Public: Parses data returned from the Trivia Crack API to create a
    # TriviaCrack::Game object.
    #
    # raw_data  - A hash of the raw data returned by the Trivia Crack API.
    #
    # Examples
    #
    #   raw_data = get_raw_data_from_API
    #   ...
    #   game = TriviaCrack::Game.from raw_data
    #
    # Returns nothing.
    def self.from(raw_data)
      questions = []
      if raw_data["spins_data"]
        raw_data["spins_data"]["spins"][0]["questions"].each do |question_data|
          question_data["type"] = raw_data["spins_data"]["spins"][0]["type"]
          question = TriviaCrack::Question.from question_data
          questions << question
        end
      end

      opponent = TriviaCrack::User.from raw_data["opponent"]

      TriviaCrack::Game.new id: raw_data["id"], opponent: opponent,
                            game_status: raw_data["game_status"],
                            language: raw_data["language"],
                            created: raw_data["created"],
                            last_turn: raw_data["last_turn"],
                            type: raw_data["type"],
                            expiration_date: raw_data["expiration_date"],
                            my_turn: raw_data["my_turn"],
                            round_number: raw_data["round_number"],
                            sub_status: raw_data["sub_status"],
                            previous_sub_status: raw_data["previous_sub_status"],
                            is_random: raw_data["is_random"],
                            unread_messages: raw_data["unread_messages"],
                            status_version: raw_data["status_version"],
                            available_crowns: raw_data["available_crowns"],
                            questions: questions
    end
  end
end
