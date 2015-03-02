# Public: An object representing a Trivia Crack Question, including the list of
# available answers as well as the correct answer.
module TriviaCrack
  class Question

    # Public: The unique identifier of the question.
    attr_reader :id

    # Public: The type of the question (e.g. :normal, :crown, :duel).
    attr_reader :type

    # Public: The category of the question (e.g. :arts, :geography, etc).
    attr_reader :category

    # Public: The question text.
    attr_reader :text

    # Public: The list of possible answers to the question.
    attr_reader :answers

    # Public: The index of the correct answer (based on the :answers property).
    attr_reader :correct_answer

    # Public: The type of media used by the question (e.g. :normal, :image).
    attr_reader :media_type

    def initialize(id:, type: nil, category: nil, text: nil, answers: nil,
                   correct_answer: nil, media_type: nil)
      @id             = id
      @type           = type
      @category       = category
      @text           = text
      @answers        = answers
      @correct_answer = correct_answer
      @media_type     = media_type
    end

  end
end
