$:.unshift File.expand_path("../lib", __FILE__)
require "bank-of-israel/version"

Gem::Specification.new do |s|
  s.name        = "bank-of-israel"
  s.version     = BankOfIsrael::VERSION
  s.date        = "2014-05-30"
  s.summary     = "Bank Of Israel exchange rates client"
  s.description = "Bank Of Israel exchange rates client"
  s.authors     = ["Dan Evron"]
  s.email       = "danevron@gmail.com"
  s.files       = %w(README.md LICENSE Gemfile) + Dir["{lib,spec}/**/*"]
  s.homepage    = "https://github.com/danevron/bank-of-israel"
  s.license     = "MIT"

  s.add_development_dependency "rspec"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"

  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "multi_xml"
end
