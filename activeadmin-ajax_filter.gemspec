# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_admin/ajax_filter/version'

Gem::Specification.new do |gem|
  gem.name          = 'activeadmin-ajax_filter'
  gem.version       = ActiveAdmin::AjaxFilter::VERSION
  gem.authors       = ['Alex Emelyanov']
  gem.email         = ['aemelyanov@spbtv.com']

  gem.summary       = 'AJAX filters for ActiveAdmin'
  gem.description   = 'Allows to define form inputs and filters by relation for ActiveAdmin resource pages using Ransacker to dynamicaly load items while user is typing symbols in filter'
  gem.homepage      = 'https://github.com/holyketzer/activeadmin-ajax_filter'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency 'activeadmin', '>= 1.0.0.pre1'
  gem.add_dependency 'rails', '>= 4'
  gem.add_dependency 'coffee-rails', '>= 4.1.0'
  gem.add_dependency 'selectize-rails', '>= 0.11.2'
  gem.add_dependency 'has_scope', '>= 0.6.0' # Force Ruby 2.1.5 support
  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rspec', '~> 3.3', '>= 3.3.0'
  gem.add_development_dependency 'rspec-rails', '~> 3.3'
  gem.add_development_dependency 'factory_girl_rails'
  gem.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.11'
  gem.add_development_dependency 'temping', '~> 3.3', '>= 3.3.0'
  gem.add_development_dependency 'codeclimate-test-reporter', '~> 0.4'
  gem.add_development_dependency 'capybara', '~> 2.1'
  gem.add_development_dependency 'phantomjs', '~> 2.1.1'
  gem.add_development_dependency 'poltergeist', '~> 1.10.0'
  gem.add_development_dependency 'selectize-rails', '>= 0.11.2'
  gem.add_development_dependency 'database_cleaner', '~> 1.5.0'
  gem.add_development_dependency 'launchy', '~> 2.4.3'
end
