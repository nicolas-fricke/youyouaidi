# Youyouaidi

[![Gem Version](https://badge.fury.io/rb/youyouaidi.svg)](https://rubygems.org/gems/youyouaidi)
[![Build Status](https://travis-ci.org/nicolas-fricke/youyouaidi.svg)](https://travis-ci.org/nicolas-fricke/youyouaidi)


Ruby Gem `Youyouaidi` offers a UUID class for parsing, validating and converting UUIDs into / from shorter representations.

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
uuid_short  = '_oGOAbD9fsFFEHWSMal1v'                # Same UUID in its short format

Youyouaidi::UUID.valid? uuid_string # => true

uuid = UUID uuid_string   # creates new Youyouaidi::UUID object, patches Youyouaidi::UUID.parse uuid_string into kernel.
# => #<Youyouaidi::UUID:0x0000010150bb60 @converter=Youyouaidi::Converter, @uuid="550e8400-e29b-41d4-a716-446655440000">
# or alternatively a short UUID can be passed
uuid = UUID uuid_short    # creates similar Youyouaidi::UUID object
# => #<Youyouaidi::UUID:0x0000010150bb60 @converter=Youyouaidi::Converter, @uuid="550e8400-e29b-41d4-a716-446655440000">

uuid.to_s                 # Returns the string representation of the UUID object
# => '550e8400-e29b-41d4-a716-446655440000'
uuid.to_short_s           # Returns the short string representation of the UUID object
# => '_oGOAbD9fsFFEHWSMal1v', alias for method: #to_param
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/youyouaidi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
