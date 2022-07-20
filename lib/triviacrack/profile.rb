# frozen_string_literal: true

# Public: An object containing the Trivia Crack profile information of a user.
module TriviaCrack
  class Profile
    # Public: The unique identifier of the user.
    attr_reader :id

    # Public: The user's Facebook name.
    attr_reader :facebook_name

    # Public: Boolean indicating whether the user is your friend.
    attr_reader :is_friend

    # Public: Boolean indicating whether you have blocked the user.
    attr_reader :is_blocked

    # Public: The user's username.
    attr_reader :username

    # Public: The user's country (e.g. :ca, :us).
    attr_reader :country

    # Public: The user's email address.
    attr_reader :email

    # Public: The datetime of the user's last play.
    attr_reader :last_play

    # Public: The datetime of the user's last login.
    attr_reader :last_login

    # Public: Number of games won by the user.
    attr_reader :games_won

    # Public: Number of games lost by the user.
    attr_reader :games_lost

    # Public: Number of games resigned by the user.
    attr_reader :games_resigned

    # Public: Number of consecutive games won by the user.
    attr_reader :consecutive_games_won

    # Public: Number of consecutive correctly answered questions by the user.
    attr_reader :consecutive_answers_correct

    # Public: The user's level.
    attr_reader :level

    # Public: Number of challenges won by the user.
    attr_reader :challenges_won

    # Public: Number of challenges lost by the user.
    attr_reader :challenges_lost

    # Public: A hash of TriviaCrack::CategoryStatistics, containing the user's
    # statistics for individual categories.
    attr_reader :categories

    # Public: Number of games won against the requesting user.
    attr_reader :my_wins_vs_user

    # Public: Number of games lost against the requesting user.
    attr_reader :my_losses_vs_user

    def initialize(id: nil, facebook_name: nil, is_friend: nil, is_blocked: nil, # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/ParameterLists
                   username: nil, country: nil, email: nil, last_play: nil,
                   last_login: nil, games_won: nil, games_lost: nil,
                   games_resigned: nil, consecutive_games_won: nil,
                   consecutive_answers_correct: nil, level: nil,
                   challenges_won: nil, challenges_lost: nil, categories: nil,
                   my_wins_vs_user: nil, my_losses_vs_user: nil)
      @id                           = id
      @facebook_name                = facebook_name
      @is_friend                    = is_friend
      @is_blocked                   = is_blocked
      @username                     = username
      @country                      = country
      @email                        = email
      @last_play                    = last_play
      @last_login                   = last_login
      @games_won                    = games_won
      @games_lost                   = games_lost
      @games_resigned               = games_resigned
      @consecutive_games_won        = consecutive_games_won
      @consecutive_answers_correct  = consecutive_answers_correct
      @level                        = level
      @challenges_won               = challenges_won
      @challenges_lost              = challenges_lost
      @categories                   = categories
      @my_wins_vs_user              = my_wins_vs_user
      @my_losses_vs_user            = my_losses_vs_user
    end
  end
end
