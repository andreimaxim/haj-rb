require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'jars/installer'

desc 'Download and vendor the jars needed'
task :setup do
  Jars::Installer.vendor_jars!
end

task :default => :spec
