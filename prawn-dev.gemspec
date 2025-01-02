# frozen_string_literal: true

require_relative 'lib/prawn/dev/version'

Gem::Specification.new do |spec|
  spec.name = 'prawn-dev'
  spec.version = Prawn::Dev::VERSION
  spec.authors = ['Alexander Mankuta']
  spec.email = ['alex@pointless.one']

  spec.summary = 'Shared tools for Prawn projects development'
  spec.homepage = 'https://prawnpdf.org/'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'
  spec.required_rubygems_version = '>= 2.0'

  spec.cert_chain = ['certs/pointlessone.pem']
  if $PROGRAM_NAME.end_with?('gem')
    spec.signing_key = File.expand_path('~/.gem/gem-private_key.pem')
  end

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/prawnpdf/prawn-dev'

  spec.files = Dir['lib/**/*.rb', 'rubocop.yml', 'templates/**/*', 'LICENSE.txt']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency('kramdown', '~> 2.4.0')
  spec.add_runtime_dependency('kramdown-parser-gfm', '~> 1.1')
  spec.add_runtime_dependency('rake', '~> 13.0')
  spec.add_runtime_dependency('rouge', '~> 4.2')
  spec.add_runtime_dependency('rspec', '~> 3.12')
  spec.add_runtime_dependency('rubocop', '~> 1.61.0')
  spec.add_runtime_dependency('rubocop-performance', '~> 1.20.2')
  spec.add_runtime_dependency('rubocop-rspec', '~> 2.26.1')
  spec.add_runtime_dependency('simplecov', '~> 0.22.0')
  spec.add_runtime_dependency('webrick', '~> 1.8.1')
  spec.add_runtime_dependency('yard', '~> 0.9.35')
end
