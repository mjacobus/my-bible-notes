# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Run prettier'
task lint: :environment do
  `./node_modules/.bin/prettier --write app/components app/assets app/javascript`
end

namespace :db do
  desc 'Make migration with output'
  task(migrate_with_sql: :environment) do
    ActiveRecord::Base.logger = Logger.new($stdout)
    Rake::Task['db:migrate'].invoke
  end

end

namespace :data do
  namespace :migrate do
    desc "Migrate territory assignments"
    task(territory_assignments: :environment) do
      TerritoryAssignmentMigration.new.migrate
    end
  end
end
