# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "paranoid_dummy/version"

Gem::Specification.new do |s|
  s.name        = "paranoid_dummy"
  s.version     = ParanoidDummy::VERSION
  s.authors     = ["Matthias Stiller"]
  s.email       = ["matthias.stiller@metascape.de"]
  s.homepage    = ""
  s.summary     = %q{Replace nil objects with predefined dummy objects.}
  s.description = %q{paranoid_dummy replaces belongs_to associations that return nil objects with predefined dummy objects.}

  s.rubyforge_project = "paranoid_dummy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.1.0"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3-ruby"
end
