lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'finalizable/version'

Gem::Specification.new do |spec|
  spec.name          = 'finalizable'
  spec.version       = Finalizable::VERSION
  spec.authors       = ['Shigeru Hagiwara']
  spec.email         = ['hgwrsgr@gmail.com']

  spec.summary       = %q{Preventing overriding specific methods.}
  spec.description   = %q{This gem makes the specified method non-overridable in Ruby.}
  spec.homepage      = 'https://rubygems.org/gems/finalizable'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

   spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/hgwr/finalizable/'
  spec.metadata['changelog_uri'] = 'https://github.com/hgwr/finalizable/'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.4'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_development_dependency 'pry-byebug', '~> 3.9.0'
  spec.add_development_dependency 'rubocop', '~> 0.93.0'
end
