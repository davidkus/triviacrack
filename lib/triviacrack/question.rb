module TriviaCrack
  class Question
    attr_reader :id, :type, :category, :text, :answers, :correct_answer,
                :media_type

    def initialize(id: 0, type: nil, category: nil, text: nil, answers: nil,
                   correct_answer: nil, media_type: nil)
      @id = id
      @type = type
      @category = category
      @text = text
      @answers = answers
      @correct_answer = correct_answer
      @media_type = media_type
    end

    # Public: Parses data returned from the Trivia Crack API to create a
    # TriviaCrack::Question object.
    #
    # raw_data  - A hash of the raw data returned by the Trivia Crack API.
    #
    # Examples
    #
    #   raw_data = get_raw_data_from_API
    #   ...
    #   question = TriviaCrack::Question.from raw_data
    #
    # Returns a TriviaCrack::Question.
    def self.from(raw_data)
      TriviaCrack::Question.new id: raw_data["id"], type: raw_data["type"],
                                category: raw_data["category"],
                                text: raw_data["text"],
                                answers: raw_data["answers"],
                                correct_answer: raw_data["correct_answer"],
                                media_type: raw_data["media_type"]
    end
  end
end
