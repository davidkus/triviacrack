module TriviaCrack
  class User
    attr_reader :id, :username, :facebook_id, :facebook_name, :coins, :lives,
                :max_lives, :unlimited_lives, :country, :extra_shots, :level,
                :level_points, :level_progress, :goal_points, :level_up

    def initialize(id: 0, username: nil, facebook_id: nil, facebook_name: nil,
                   coins: nil, lives: nil, max_lives: nil, unlimited_lives: nil,
                   country: nil, extra_shots: nil, level: nil,
                   level_points: nil, level_progress: nil, goal_points: nil,
                   level_up: nil)
      @id = id
      @username = username
      @facebook_id = facebook_id
      @facebook_name = facebook_name
      @coins = coins
      @lives = lives
      @max_lives = max_lives
      @unlimited_lives = unlimited_lives
      @country = country
      @extra_shots = extra_shots
      @level = level
      @level_points = level_points,
      @level_progress = level_progress
      @goal_points = goal_points
      @level_up = level_up
    end

    # Public: Returns true if the user has one or more lives, or has unlimited
    # lives.
    #
    # Examples
    #
    #   if user.start_new_game?
    #      ... start a new game ...
    #   end
    #
    # Returns true if the user can start a new game, false otherwise.
    def start_new_game?
      @lives >= 1 || @unlimited_lives
    end

    # Public: Parses data returned from the Trivia Crack API to create a
    # TriviaCrack::User object.
    #
    # raw_data  - A hash of the raw data returned by the Trivia Crack API.
    #
    # Examples
    #
    #   raw_data = get_raw_data_from_API
    #   ...
    #   user = TriviaCrack::User.from raw_data
    #
    # Returns a TriviaCrack::User.
    def self.from(raw_data)
      lives = raw_data["lives"]
      level_data = raw_data["level_data"]

      TriviaCrack::User.new id: raw_data["id"], username: raw_data["username"],
                            facebook_id: raw_data["facebook_id"],
                            facebook_name: raw_data["facebook_name"],
                            coins: raw_data["coins"],
                            lives: lives ? lives["quantity"] : nil,
                            max_lives: lives ? lives["max"] : nil,
                            unlimited_lives: lives ? lives["unlimited"] : nil,
                            country: raw_data["country"],
                            extra_shots: raw_data["extra_shots"],
                            level: level_data ? level_data["level"] : nil,
                            level_points: level_data ? level_data["points"] : nil,
                            level_progress: level_data ? level_data["progress"] : nil,
                            goal_points: level_data ? level_data["goal_points"] : nil,
                            level_up: level_data ? level_data["level_up"] : nil
    end
  end
end
