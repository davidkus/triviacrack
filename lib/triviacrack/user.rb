# Public: An object representing a Trivia Crack User, including information
# about the user's level, lives and coins.
module TriviaCrack
  class User

    # Public: The unique identifier of the user.
    attr_reader :id

    # Public: The unique username of the user.
    attr_reader :username

    # Public: The Facebook ID of the user (nil if the user has not linked their
    # Facebook account).
    attr_reader :facebook_id

    # Public: The Facebook name of the user (nil if the user has not linked
    # their Facebook account).
    attr_reader :facebook_name

    # Public: The amount of coins that the user has accumulated.
    attr_reader :coins

    # Public: The amount of lives available to the user.
    attr_reader :lives

    # Public: The maximum number of lives that the user can have.
    attr_reader :max_lives

    # Public: Boolean indicating whether the user has unlimited lives.
    attr_reader :unlimited_lives

    # Public: The country code of the user's country.
    attr_reader :country

    # Public: The number of extra shots available to the user.
    attr_reader :extra_shots

    # Public: The user's level.
    attr_reader :level

    # Public: The experience points that the user has accumulated towards their
    # next level.
    attr_reader :level_points

    # Public: The percentage progress towards the next level.
    attr_reader :level_progress

    # Public: The user's goal points.
    attr_reader :goal_points

    # Public: Boolean indicating whether the user has leveled up.
    attr_reader :level_up

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
      @level_points     = level_points
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
