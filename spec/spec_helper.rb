require 'rspec'

require 'bundler'
Bundler.require

# Code coverage statistics at coveralls.io: https://coveralls.io/r/nicolas-fricke/youyouaidi
# Generate coverage reports only when using MRI, see: https://github.com/lemurheavy/coveralls-public/issues/144
if ENV['TRAVIS'] && ENV['COVERALLS'] && RUBY_ENGINE == 'ruby'
  require 'coveralls'
  Coveralls.wear!
end

require 'youyouaidi'

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # Raise error when using old :should expectation syntax.
  # config.raise_errors_for_deprecations!
end
