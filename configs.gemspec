# -*- encoding: utf-8 -*-
require File.expand_path('../lib/configs/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Lance Ivy"]
  gem.email         = ["lance@cainlevy.net"]
  gem.description   = "Easy (easier?) management of config/*.yml files. Defines a lookup priority for the current environment's settings."
  gem.summary       = "Easy (easier?) management of config/*.yml files."
  gem.homepage      = "http://github.com/kickstarter/configs"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "configs"
  gem.require_paths = ["lib"]
  gem.version       = Configs::VERSION

  gem.add_dependency 'activesupport', '>3.0'
  gem.add_development_dependency "rake"
end
