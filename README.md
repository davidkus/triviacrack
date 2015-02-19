# Triviacrack

A Ruby interface for the Trivia Crack API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'triviacrack'
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

Then, use the client to log in using your Trivia Crack email and password.

```ruby
client.login "user@example.com", "password123"
```

Now, you can make requests to the Trivia Crack API.

```ruby
# Get information about the currently logged in user
user = client.get_user

# Get the list of games available to the currently logged in user
games = client.get_games

# Answer a question for on of those games
game = games.first
client.answer_question game.id, game.question.first, 0
```

## Contributing

1. Fork it ( https://github.com/davidkus/triviacrack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
