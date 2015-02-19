module TriviaCrack
  module Errors
    class RequestError < StandardError
      attr_reader :code

      def initialize(code)
        @code = code
      end
    end
  end
end
