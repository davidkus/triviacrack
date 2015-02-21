# Public: An object representing a Trivia Crack User, including information
# about the user's level, lives and coins.
module TriviaCrack
  class User

    attr_reader :id, :username, :facebook_id, :facebook_name, :coins, :lives,
                :max_lives, :unlimited_lives, :country, :extra_shots, :level,
                :level_points, :level_progress, :goal_points, :level_up

    def initialize(id:, username: nil, facebook_id: nil, facebook_name: nil,
                   coins: nil, lives: nil, max_lives: nil, unlimited_lives: nil,
                   country: nil, extra_shots: nil, level: nil,
                   level_points: nil, level_progress: nil, goal_points: nil,
                   level_up: nil)
      @id               = id
      @username         = username
      @facebook_id      = facebook_id
      @facebook_name    = facebook_name
      @coins            = coins
      @lives            = lives
      @max_lives        = max_lives
      @unlimited_lives  = unlimited_lives
      @country          = country
      @extra_shots      = extra_shots
      @level            = level
      @level_points     = level_points,
      @level_progress   = level_progress
      @goal_points      = goal_points
      @level_up         = level_up
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

  end
end
