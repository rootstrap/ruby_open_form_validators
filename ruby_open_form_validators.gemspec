# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_open_form_validators/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_open_form_validators'
  spec.version       = RubyOpenFormValidators::VERSION
  spec.authors       = ['Elián Marchisio']
  spec.email         = ['elian.marchisio@rootstrap.com']

  spec.summary       = 'Ruby gem for validating OpenForm.'
  spec.homepage      = 'https://github.com/rootstrap/ruby_open_form_validators'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'reek', '~> 5.5.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.76.0'

  spec.add_dependency 'activesupport', '~> 5.2', '>= 5.2.3'
end
