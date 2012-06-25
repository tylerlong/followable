# -*- encoding: utf-8 -*-
require File.expand_path('../lib/followable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tyler Long"]
  gem.email         = ["tyler4long@gmail.com"]
  gem.description   = "Make an ActiveRecord model followable, such as user follow user, user follow projects...etc."
  gem.summary       = "Make an ActiveRecord model followable"
  gem.homepage      = "https://github.com/tylerlong/followable"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "followable"
  gem.require_paths = ["lib"]
  gem.version       = Followable::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "supermodel"
end
