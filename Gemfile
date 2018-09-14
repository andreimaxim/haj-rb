source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in haj.gemspec
gemspec

# A bunch of gems required for benchmarking, so we're sure we're on the right
# track and actually providing a performance gain.
gem 'benchmark-ips', '~> 2.7'

gem 'faker'
gem 'sequel', '~> 5.12'
gem 'jdbc-postgres', '~> 42.1'
gem 'redis', '~> 4.0'
gem 'jedis_rb', '~> 2.7'