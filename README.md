# Triviacrack [![Build Status](https://travis-ci.org/davidkus/triviacrack.svg?branch=master)](https://travis-ci.org/davidkus/triviacrack) [![Code Climate](https://codeclimate.com/github/davidkus/triviacrack/badges/gpa.svg)](https://codeclimate.com/github/davidkus/triviacrack) [![Test Coverage](https://codeclimate.com/github/davidkus/triviacrack/badges/coverage.svg)](https://codeclimate.com/github/davidkus/triviacrack)

A Ruby interface for the Trivia Crack API.

The Trivia Crack iOS app uses an undocumented API to store / retrieve
information about the game state. This Ruby library wraps that API and presents
it in a clean, documented way.

*Disclaimer*: The Trivia Crack API is undocumented and subject to change at any
time. Changes in the API _may_ break this library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "triviacrack"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install triviacrack

## Usage

First, create an instance of the `TriviaCrack::API::Client`.

```ruby
require "triviacrack"

client = TriviaCrack::API::Client.new
```

### Logging In

Use the client to log in using your Trivia Crack email and password.

```ruby
client.login "user@example.com", "password123"
```

### User Information

You can retrieve information about the currently logged in user.

```ruby
user = client.get_user

puts "Hello, #{user.username}!"
 # => Hello, david!
```

You can also retrieve the user ID of the user with a given username.

```ruby
user_id = client.get_user_id "david"

puts "david's user id is #{user_id}"
 # => david's user id is 1
```

### User Profiles

You can retrieve additional information about a user by fetching their profile.

```ruby
user_id = 123
profile = client.get_profile user_id
```

A user's profile contains their statistics (number of wins / losses, number of
questions answered correctly, etc), among other things.

### Game Information

You can retrieve the list of games available to the currently logged in user.

```ruby
games = client.get_games
```

You can retrieve game information for a specific game (by id).

```ruby
game = client.get_game 1
```

You can also start a new game.

```ruby
game = client.start_new_game
```

The TriviaCrack::Game object holds information about the opponent, statistics,
and current questions available to be answered.

### Answering Questions

It is possible to answer questions using the Trivia Crack API.

```ruby
game = client.get_game 1

client.answer_question game.id, game.question.first, 0
```

The `answer_question` also returns an updated `TriviaCrack::Game` object, so you
can avoid making additional API calls to keep the game object up to date.

```ruby
game = client.answer_question game.id, game.question.first, 0
```

## Contributing

1. Fork it ( https://github.com/davidkus/triviacrack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
