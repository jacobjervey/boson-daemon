# -*- encoding: utf-8 -*-
require File.expand_path('../lib/boson-daemon/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jacob Jervey"]
  gem.email         = ["jake@boson.io"]
  gem.description   = %q{The remote ruby agent for Boson.io responsible for managing and installing gameservers}
  gem.summary       = %q{Ruby agent for Boson.io}
  gem.homepage      = "http://boson.io"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "boson-daemon"
  gem.require_paths = ["lib"]
  gem.version       = Boson::Daemon::VERSION

  gem.add_dependency 'pubnub'
  gem.add_dependency 'json'
end
