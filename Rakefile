# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
Rake.application.instance_variable_get('@tasks').delete('assets:precompile')
namespace :assets do
  desc 'disable assets:precompile'
  task :precompile do
  end
end
