# frozen_string_literal: true

# Read VERSION directly without requiring `email_validation/version`, which
# itself requires `localized_each_validator` — a runtime dep that may not yet
# be installed when this gemspec is first evaluated.
version = File.read(File.expand_path("lib/email_validation/version.rb", __dir__))
           .match(/VERSION\s*=\s*["']([^"']+)["']/)[1]

Gem::Specification.new do |spec|
  spec.name        = "email_validation"
  spec.version     = version
  spec.authors     = ["Tim Morgan"]
  spec.email       = ["git@timothymorgan.info"]

  spec.summary     = "Simple, localizable email address validator for ActiveModel"
  spec.description = "A simple, localizable EachValidator for email address fields. " \
                     "Drop in to any ActiveModel-based class and use `validates :foo, email: true`."
  spec.homepage    = "https://github.com/RISCfuture/email_validation"
  spec.license     = "MIT"

  spec.required_ruby_version = ">= 3.1"

  spec.metadata = {
    "homepage_uri"          => spec.homepage,
    "source_code_uri"       => "#{spec.homepage}/tree/master",
    "changelog_uri"         => "#{spec.homepage}/blob/master/CHANGELOG.md",
    "bug_tracker_uri"       => "#{spec.homepage}/issues",
    "rubygems_mfa_required" => "true"
  }

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").select { |f| File.exist?(f) }.reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github .idea Gemfile])
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", ">= 6.1"
  spec.add_dependency "localized_each_validator", ">= 2.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "standard", ">= 1.0"
end
