
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'haj/version'

Gem::Specification.new do |spec|
  spec.name          = 'haj-rb'
  spec.version       = HAJ::VERSION
  spec.authors       = ['Andrei Maxim']
  spec.email         = ['andrei@andreimaxim.ro']

  spec.summary       = 'Highly-Advanced Jedis client for Ruby'
  spec.homepage      = 'https://github.com/andreimaxim/haj-rb'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_development_dependency 'pry', '~> 0.11'
  
  # A bunch of gems required for benchmarking, so we're sure we're on the right
  # track and actually providing a performance gain.
  spec.add_development_dependency 'benchmark-ips', '~> 2.7'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'sequel', '~> 5.12'
  spec.add_development_dependency 'jdbc-postgres', '~> 42.1'
  spec.add_development_dependency 'redis', '~> 4.0'
  spec.add_development_dependency 'jedis_rb', '~> 2.7'
end
