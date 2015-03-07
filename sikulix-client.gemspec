$:.push File.expand_path("../lib", __FILE__)

require "sikulix-client/version"
Gem::Specification.new do |s|
  s.name = "sikulix-client"
  s.version = SikulixClient::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Jason Gowan"]
  s.email = ["gowanjason@gmail.com"]
  s.homepage = "https://github.com/jesg/sikulix-client"
  s.summary = %q{Client library for REST interface to sikulix2}
  s.description = %q{Client library for REST interface to sikulix2}
  s.rubyforge_project = "sikulix-client"

  s.add_dependency "excon"
  s.add_dependency "json"

  s.add_development_dependency "rspec", "~> 3.2.0"
  s.add_development_dependency "rake", "~> 10.4.2"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
