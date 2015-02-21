# Public: An object representing a Trivia Crack Question, including the list of
# available answers as well as the correct answer.
module TriviaCrack
  class Question

    attr_reader :id, :type, :category, :text, :answers, :correct_answer,
                :media_type

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
