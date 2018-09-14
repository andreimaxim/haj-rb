require 'bundler/setup'

if ENV['CC_TEST_REPORTER_ID']
  require 'simplecov'

  SimpleCov.profiles.define 'HAJ' do
    add_filter '/bin/'
    add_filter '/data/'
    add_filter '/spec/'

    add_filter '/lib/org/apache/commons/commons-pool2/2.4.2/'
    add_filter '/lib/redis/clients/jedis/2.9.0/'

    add_group 'HAJ', 'lib'
  end

  puts 'Starting SimpleCov'

  SimpleCov.start 'HAJ'
end

require 'haj'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
