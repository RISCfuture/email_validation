# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

begin
  require "standard/rake"
rescue LoadError
  # standard is optional in CI matrix runs
end

task default: :spec
