# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'engine-jrubyfx/version'

Gem::Specification.new do |gem|
  gem.name          = "engine-jrubyfx"
  gem.version       = JavaFXEngine::JFXGen::VERSION
  gem.authors       = ["Jeremy Ebler"]
  gem.email         = ["jebler@gmail.com"]
  gem.description   = %q{https://github.com/carldea/JFXGen's engine in jRuby with jRubyFX}
  gem.summary       = %q{secret}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'jrubyfx', '~> 0.9.2'
end
