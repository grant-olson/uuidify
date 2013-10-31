$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "uuidify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "uuidify"
  s.version = Uuidify::VERSION
  s.date = "2013-10-17"
  s.summary = "Add uuids to any ActiveRecord model."

  s.authors = ["Grant Olson"]
  s.email = "kgo@grant-olson.net"

  s.summary = "Generate uuids for models"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "LICENSE"]
  s.test_files = Dir["spec/**/*"]
  s.extra_rdoc_files = ['README.md']

  s.homepage = "https://github.com/grant-olson/uuidify"
  s.license = "BSD 3 Clause"

  s.add_dependency "rails", ">= 3.2.13"
  s.add_dependency "uuidtools", "~> 2.1.4"

  s.add_development_dependency "mysql2"
  s.add_development_dependency "rspec-rails", "~> 2.13.0"
  s.add_development_dependency "database_cleaner"
end
