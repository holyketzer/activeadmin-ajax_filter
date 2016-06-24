require 'bundler/gem_tasks'


require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task default: ['dummy:prepare', :spec]

require 'rake/clean'
CLEAN.include 'spec/dummy/db/*sqlite3', 'spec/dummy/log/*', 'spec/dummy/public/assets/*', 'spec/dummy/tmp/**/*'

namespace :dummy do
  desc 'Setup dummy app database'
  task :prepare do
    # File.expand_path is executed directory of generated Rails app
    rakefile = File.expand_path('Rakefile', dummy_path)
    command = "rake -f '%s' db:schema:load RAILS_ENV=test" % rakefile
    sh(command) unless ENV['DISABLE_CREATE']
  end

  def dummy_path
    rel_path = ENV['DUMMY_APP_PATH'] || 'spec/dummy'
    if @current_path.to_s.include?(rel_path)
      @current_path
    else
      @current_path = File.expand_path(rel_path)
    end
  end
end
