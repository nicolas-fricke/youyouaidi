# Youyouaidi
[![Gem Version](https://badge.fury.io/rb/youyouaidi.svg)](https://rubygems.org/gems/youyouaidi)
[![Build Status](https://travis-ci.org/nicolas-fricke/youyouaidi.svg)](https://travis-ci.org/nicolas-fricke/youyouaidi)
[![Coverage Status](http://img.shields.io/coveralls/nicolas-fricke/youyouaidi.svg)](https://coveralls.io/r/nicolas-fricke/youyouaidi)
[![Code Climate](http://img.shields.io/codeclimate/github/nicolas-fricke/youyouaidi.svg)](https://codeclimate.com/github/nicolas-fricke/youyouaidi)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](https://tldrlegal.com/license/mit-license)


`Youyouaidi` is a Ruby Gem that offers a UUID class for **generating**, **parsing**, **validating** and **converting** UUIDs into / from **shorter representations**.

While a **UUID consists of 36 characters** – 32 hexadecimal characters, divided by four dashes into five subgroups – the **short representation** (invoked via `#to_short_string`) consists of exactly **22 digit and lower- and uppercase characters**.

This is what a valid, random (version 4) UUID looks like:
```
                          version    either 8, 9
                           number    a, or b
                                ▼    ▼
                  caed3f49-b0ca-454b-adf8-5ee2a1764759
# chars in group:     8   | 4  | 4  | 4  |    12
```
As shown, the first digit of the third group indicates the UUID version.
The first digit of the fourth group always has to be one of either `8`, `9`, `a`, or `b`.
All other digits are randomly assigned hexadecimals.

And this is the same UUID in its short format: `6aUS5foeLu2VGDspRPc7bz`.

For UUID generation, the `SecureRandom.uuid` method is used which generates valid, random *version 4* UUIDs.

Find out more about UUIDs and the different versions on [Wikipedia](https://en.wikipedia.org/wiki/Uuid).

## Installation

Add this line to your application's Gemfile:

    gem 'youyouaidi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install youyouaidi

## Usage

For usability, `UUID(...)` is patched into the kernel as a shorthand call to `Youyouaidi::UUID.parse(...)`.
Also, `UUID` is patched as a reference for the class `Youyouid::UUID`.

### Initializing UUIDs

```ruby
uuid_string = '550e8400-e29b-41d4-a716-446655440000' # A valid UUID in string format, has exactly 32 hexadecimal characters in 5 groups
uuid_short  = '2AuYQJcZeiIeCymkJ7tzTW'               # Same UUID in its short format, has exactly 22 characters of [0-9a-zA-Z]

uuid = UUID uuid_string   # creates new Youyouaidi::UUID object, patches Youyouaidi::UUID.parse uuid_string into kernel.
# => #<Youyouaidi::UUID:0x000001021f2590 @converter=Youyouaidi::Converter, @uuid="550e8400-e29b-41d4-a716-446655440000">

# Alternatively a short UUID can be passed:
uuid = UUID uuid_short    # creates similar Youyouaidi::UUID object
# => #<Youyouaidi::UUID:0x00000102201b80 @converter=Youyouaidi::Converter, @uuid="550e8400-e29b-41d4-a716-446655440000">

# To generate a new random UUID simply do not pass a parameter:
new_uuid = UUID()         # generates a random UUID version 4 using the SecureRandom.uuid method
# => #<Youyouaidi::UUID:0x00000102201b80 @converter=Youyouaidi::Converter, @uuid="27f8bc29-be8e-4dc7-ab30-0295b2a5e902">
```


### Validity check and conversions

The validity check `UUID.valid? uuid_string` checks, if UUID contains exactly 32 hexadecimal characters which are divided by four dashes ('-') into five groups of sizes 8, 4, 4, 4, and 12.
Also, it validates that the first character of the fourth group is either a `8`, `9`, an `a`, or a `b`.

```ruby
uuid_string = '550e8400-e29b-41d4-a716-446655440000' # A valid UUID in string format
uuid = UUID uuid_string

UUID.valid? uuid_string # Checks if `uuid_string' is a valid UUID, same as Youyouaidi::UUID.valid? uuid_string
# => true

uuid.to_s               # Returns the string representation of the UUID object
# => '550e8400-e29b-41d4-a716-446655440000'

uuid.to_short_string    # Returns the short string representation of the UUID object, #to_param is an alias for this method
# => '2AuYQJcZeiIeCymkJ7tzTW'
```


### Comparing UUIDs

```ruby
uuid_string  = '550e8400-e29b-41d4-a716-446655440000' # A valid UUID in string format
uuid         = UUID uuid_string
similar_uuid = UUID uuid_string
other_uuid   = UUID '00000000-1111-2222-aaaa-eeeeeeeeeeee'

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

1. Fork it ( http://github.com/nicolas-fricke/youyouaidi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
