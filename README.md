# Youyouaidi

Ruby Gem youyouaidi offers a UUID class for parsing, validating and encoding UUIDs

## Installation

Add this line to your application's Gemfile:

    gem 'youyouaidi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install youyouaidi

## Usage

```ruby
uuid_string = '550e8400-e29b-41d4-a716-446655440000' # A valid UUID in string format

Youyouaidi::UUID.valid_uuid? uuid_string # => true

uuid = Youyouaidi::UUID.new uuid_string # creates new UUID object, alternatively a short UUID can also be passed
uuid.to_s # => '550e8400-e29b-41d4-a716-446655440000'
uuid.to_short_s # => '_oGOAbD9fsFFEHWSMal1v', alias for method: #to_param
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/youyouaidi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
