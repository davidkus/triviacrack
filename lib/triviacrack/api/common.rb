require "unirest"

# Internal: Common methods used for the Trivia Crack API.
module TriviaCrack
  module API
    module Common

      # Internal: Makes a GET request to the Trivia Crack API using the set of
      # default headers.
      #
      # url        - The URL of the TriviaCrack API resource.
      # parameters - The parameters to send with the request.
      #
      # Returns a Unirest Response object with the server's response.
      def get(url, parameters: nil)
        Unirest.get "#{API_HOST}#{url}", parameters: parameters,
                                         headers: default_headers
      end

      # Internal: Makes a POST request to the Trivia Crack API using the set of
      # default headers.
      #
      # url        - The URL of the TriviaCrack API resource.
      # parameters - The parameters to send with the request.
      #
      # Returns a Unirest Response object with the server's response.
      def post(url, parameters: nil)
        Unirest.post "#{API_HOST}#{url}", parameters: parameters,
                                          headers: default_headers
      end

      private

      # Internal: The host name of the Trivia Crack API.
      API_HOST = "https://api.preguntados.com"

      # Internal: Constructs the set of headers needed to make requests to the
      # Trivia Crack API.
      #
      # Returns a hash of headers.
      def default_headers
        headers = { "Content-Type": "application/json; charset=utf-8" }

        if @session
          headers["Cookie"] = "ap_session=#{@session}"
        end

        headers
      end

    end
  end
end
