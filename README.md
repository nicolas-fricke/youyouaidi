# Youyouaidi 
[![Gem Version](https://badge.fury.io/rb/youyouaidi.svg)](https://rubygems.org/gems/youyouaidi) 
[![Build Status](https://travis-ci.org/nicolas-fricke/youyouaidi.svg)](https://travis-ci.org/nicolas-fricke/youyouaidi)
[![Coverage Status](http://img.shields.io/coveralls/nicolas-fricke/youyouaidi.svg)](https://coveralls.io/r/nicolas-fricke/youyouaidi)
[![Code Climate](http://img.shields.io/codeclimate/github/nicolas-fricke/youyouaidi.svg)](https://codeclimate.com/github/nicolas-fricke/youyouaidi)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](https://tldrlegal.com/license/mit-license)


`Youyouaidi` is a Ruby Gem that offers a UUID class for parsing, validating and converting UUIDs into / from shorter representations.
While a UUID consists of 32 hexadecimal characters by dashes divided into 5 subgroups, the short representation (invoked via `#to_shrort_string`) consists of exactly 22 digit and lower- and uppercase characters.

## Installation

Add this line to your application's Gemfile:

    gem 'youyouaidi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install youyouaidi

## Usage

### Initializing UUIDs

```ruby
uuid_string = '550e8400-e29b-41d4-a716-446655440000' # A valid UUID in string format, has exactly 32 hexadecimal characters in 5 groups
uuid_short  = '2AuYQJcZeiIeCymkJ7tzTW'               # Same UUID in its short format, has exactly 22 characters of [0-9a-zA-Z]

uuid = UUID uuid_string   # creates new Youyouaidi::UUID object, patches Youyouaidi::UUID.parse uuid_string into kernel.
# => #<Youyouaidi::UUID:0x000001021f2590 @converter=Youyouaidi::Converter, @uuid="550e8400-e29b-41d4-a716-446655440000">

# Alternatively a short UUID can be passed:
uuid = UUID uuid_short    # creates similar Youyouaidi::UUID object
# => #<Youyouaidi::UUID:0x00000102201b80 @converter=Youyouaidi::Converter, @uuid="550e8400-e29b-41d4-a716-446655440000">
```


### Validity check and conversions

```ruby
uuid_string = '550e8400-e29b-41d4-a716-446655440000' # A valid UUID in string format
uuid = UUID uuid_string

Youyouaidi::UUID.valid? uuid_string # => true

uuid.to_s                 # Returns the string representation of the UUID object
# => '550e8400-e29b-41d4-a716-446655440000'

uuid.to_short_s           # Returns the short string representation of the UUID object
# => '2AuYQJcZeiIeCymkJ7tzTW', alias for method: #to_param
```


### Comparing UUIDs

```ruby
uuid_string  = '550e8400-e29b-41d4-a716-446655440000' # A valid UUID in string format
uuid         = UUID uuid_string
similar_uuid = UUID uuid_string
other_uuid   = UUID 'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee'

uuid == similar_uuid # Two UUID objects representing same UUID (#=== behaves similar for this)
# => true

uuid == other_uuid   # Two UUID objects representing different UUIDs (#=== behaves similar for this)
# => false

uuid == uuid_string  # Comparing a UUID object and its string representation with `=='
# => false

uuid === uuid_string # Comparing a UUID object and its string representation with `===' (case insensetive)
# => true
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/youyouaidi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
