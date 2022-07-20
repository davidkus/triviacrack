# frozen_string_literal: true

require 'json'
require 'faraday'

require 'triviacrack/errors/request_error'

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
      # Returns a Faraday Response object with the server's response.
      # Raises TriviaCrack:Errors::RequestError if the request fails.
      def get(url, parameters: nil)
        response = Faraday.get "#{API_HOST}#{url}", parameters, default_headers

        check_response url, response
      end

      # Internal: Makes a POST request to the Trivia Crack API using the set of
      # default headers.
      #
      # url        - The URL of the TriviaCrack API resource.
      # parameters - The parameters to send with the request.
      #
      # Returns a Faraday Response object with the server's response.
      # Raises TriviaCrack:Errors::RequestError if the request fails.
      def post(url, parameters: nil)
        response = Faraday.post "#{API_HOST}#{url}", parameters, default_headers

        check_response url, response
      end

      private

      # Internal: The host name of the Trivia Crack API.
      API_HOST = 'https://api.preguntados.com'

      # Internal: Constructs the set of headers needed to make requests to the
      # Trivia Crack API.
      #
      # Returns a hash of headers.
      def default_headers
        headers = { 'Content-Type': 'application/json; charset=utf-8' }

        headers['Cookie'] = "ap_session=#{@session.session_id}" if @session

        headers
      end

      # Internal: Checks the response's code to see if the request was
      # successful
      #
      # response - Faraday response returned by the API.
      #
      # Returns the response body parsed from JSON
      # Raises TriviaCrack:Errors::RequestError if the request failed.
      def check_response(url, response)
        unless response.status.between? 200, 299
          raise TriviaCrack::Errors::RequestError.new(response.status, url, response.body),
                "Request to #{API_HOST}#{url} failed with code #{response.status}."
        end

        JSON.parse(response.body)
      end
    end
  end
end
