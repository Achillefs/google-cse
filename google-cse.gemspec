# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google_cse/version'

Gem::Specification.new do |gem|
  gem.name          = "google-cse"
  gem.version       = GoogleCSE::VERSION
  gem.authors       = ["Achilles Charmpilas"]
  gem.email         = ["ac@humbuckercode.co.uk"]
  gem.description   = %q{A wee Google CSE client}
  gem.summary       = %q{A wee Google CSE client. Use it to easily query your custom search engine. Supports image search.}
  gem.homepage      = "http://humbuckercode.co.uk/licks/gems/google-cse"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency('json')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('fuubar')
end
