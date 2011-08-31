require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "email_validation"
  gem.summary = %Q{Simple email validation in Rails 3}
  gem.description = %Q{A simple, localizable EachValidator for email address fields in ActiveRecord 3.0.}
  gem.email = "git@timothymorgan.info"
  gem.homepage = "http://github.com/riscfuture/email_validation"
  gem.authors = [ "Tim Morgan" ]
  gem.files = %w( lib/**/* README.textile email_validation.gemspec LICENSE )
end
Jeweler::RubygemsDotOrgTasks.new

require 'yard'
YARD::Rake::YardocTask.new('doc') do |doc|
  doc.options << "-m" << "textile"
  doc.options << "--protected"
  doc.options << "-r" << "README.textile"
  doc.options << "-o" << "doc"
  doc.options << "--title" << "email_validation Documentation"
  
  doc.files = %w( lib/**/* README.textile )
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task(default: :spec)
