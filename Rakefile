require 'rake'
begin
  require 'bundler'
rescue LoadError
  puts "Bundler is not installed; install with `gem install bundler`."
  exit 1
end

Bundler.require :default

Jeweler::Tasks.new do |gem|
  gem.name = "email_validation"
  gem.summary = %Q{Simple email validation in Rails 3}
  gem.description = %Q{A simple, localizable EachValidator for email address fields in ActiveRecord 3.0.}
  gem.email = "git@timothymorgan.info"
  gem.homepage = "http://github.com/riscfuture/email_validation"
  gem.authors = [ "Tim Morgan" ]
  gem.add_dependency 'localized_each_validator', '>= 1.0.1'
end
Jeweler::GemcutterTasks.new

YARD::Rake::YardocTask.new('doc') do |doc|
  doc.options << "-m" << "textile"
  doc.options << "--protected"
  doc.options << "-r" << "README.textile"
  doc.options << "-o" << "doc"
  doc.options << "--title" << "email_validation Documentation".inspect
  
  doc.files = [ 'lib/*_validator.rb', 'README.textile' ]
end
