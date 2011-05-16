# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mortimer/version"

Gem::Specification.new do |s|
  s.name        = "mortimer"
  s.version     = Mortimer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael DeHaan", "Nathan L. Walls"]
  s.email       = ["michael.dehaan AT gmail DOT com", "nathan AT wallscorp DOT us"]
  s.homepage    = "https://github.com/mpdehaan/mortimer"
  s.summary     = "mortimer-#{Mortimer::VERSION}"
  s.description = %q{A simple way to turn Markup-based files into project documentation}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency('maruku')
end
