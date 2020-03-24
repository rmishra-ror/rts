# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rts/version'

Gem::Specification.new do |spec|
  spec.name          = 'rts'
  spec.version       = RTS::VERSION
  spec.authors       = ['Rahul']
  spec.email         = ['rahulismishra@gmail.com']
  spec.summary       = 'Rest Client for rts esports JSON API'
  spec.description   = 'Rest Client for RTS esports JSON API'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17', '>= 1.17.3'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.4'

  spec.add_runtime_dependency 'openssl', '~> 2.1', '>= 2.1.0'
  spec.add_runtime_dependency 'rest-client', '~> 2.1', '>= 2.1.0'
end
