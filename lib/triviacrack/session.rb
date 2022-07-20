# frozen_string_literal: true

# Public: An object representing a Trivia Crack Session.
module TriviaCrack
  class Session
    # Public: The session id.
    attr_reader :session_id

    # Public: The id of the User associated with this session.
    attr_reader :user_id

    # Public: The username of the User associated with this session.
    attr_reader :username

    # Public: The device key.
    attr_reader :device_key

    # Public: The time at which the session will expire.
    attr_reader :expiration

    def initialize(session_id:, user_id: nil, username: nil, device_key: nil,
                   expiration: nil)
      @session_id     = session_id
      @user_id        = user_id
      @username       = username
      @device_key     = device_key
      @expiration     = expiration
    end
  end
end
