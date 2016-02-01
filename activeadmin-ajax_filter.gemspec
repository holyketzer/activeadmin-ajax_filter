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
  gem.description   = 'Allows to define filter by relation for ActiveAdmin resource pages using Ransacker to dynamicaly load items while user is typing symbols in filter'
  gem.homepage      = 'https://github.com/holyketzer/activeadmin-ajax_filter'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency 'activeadmin', '>= 1.0.0.pre1'
  gem.add_dependency 'coffee-rails', '>= 4.1.0'
  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rspec', '~> 3.3.0'
  gem.add_development_dependency 'sqlite3', '~> 1.3.11'
  gem.add_development_dependency 'temping', '~> 3.3.0'
end
